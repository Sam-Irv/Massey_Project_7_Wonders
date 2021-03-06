from .trade import *
import random


def deal_wonders(players):
    wonders = Wonder.query.all()
    cardhists = []

    for player in players:
        wonder = wonders.pop(random.randint(0, len(wonders)-1))
        player.wonder = wonder.name
        player.max_wonder = wonder.slots

        card = Card.query.filter_by(name=wonder.card_0).first()
        update_player_object(card, player)
        cardhists.append(Cardhist(playerId=player.id, cardId=card.id, discarded=False, for_wonder=True,
                                  card_name=card.name, card_colour=card.colour))

    db_committing_function(p=players, c=cardhists)


def age_calcs_and_dealing(players, game):
    """Call to calculate end of age calculations
    and/or the next age's hands dealt"""
    print(game.age, " Game Age - Will Now Be Processed And Incremented")

    if game.age > 0:
        military_calcs(players, game.age)

        # Implements the babylon_2 play both cards logic
        for p in players:
            if p.play_twice:
                # Gets the final card in the player's hand and plays it
                card = get_cards(get_player(get_next_player_id(p, game.age)))[0]
                play_card_with_trade(card, p, False, False, False, no_prereq=True)
                print(p.name + " played both cards")
                p.play_twice = False

    # End of age 3 - wrap up game
    if game.age > 2:
        game.complete = True

        for p in players:
            end_game_cards(p, get_cards(player=p, history=True))
            p.points += p.money // 3

            # Implement borrow purple card, Zeus_3 wonder card, and use the highest scoring one
            if [x for x in get_cards(player=p, history=True) if x.name == 'zeus_3']:
                purples = [x for x in get_cards(player=get_player(p.left_id), history=True) +
                           get_cards(player=get_player(p.right_id), history=True) if x.colour == 'purple']
                scores = []
                for card in purples:
                    temp = p.points
                    end_game_cards(p, card)
                    scores.append(p.points - temp)
                p.points += max(scores) - sum(scores)

        db_committing_function(p=players, g=game)
        [print(p.name, p.points) for p in players]
        print("Game Over")

    # Move onto next age
    else:
        game.round = 1
        game.age += 1
        cards = Card.query.filter(Card.noPlayers <= len(players)).filter_by(age=game.age).all()

        # Only deal enough guilds for noPlayers+2
        if game.age == 3:
            guilds = [card for card in cards if card.colour == 'purple']
            random.shuffle(guilds)
            guilds = guilds[:len(players)+2]
            cards = [card for card in cards if not card.colour == 'purple' or card in guilds]

        # Randomly assign cards to players
        dealt_cards = []
        for player in players:
            for j in range(7):
                param = random.randint(0, len(cards)-1)
                card = cards.pop(param)
                dealt_cards.append(Round(age=game.age, round=1, playerId=player.id, cardId=card.id))
        db_committing_function(d=dealt_cards, p=players, g=game)


def get_next_player_id(player, age):
    if age == 2:
        return player.right_id
    else:
        return player.left_id


def set_player_neighbours(players):
    """Called at the beginning of the game to set player's left_id and right_id"""
    num_players = len(players)
    i = num_players

    for player in players:
        player.left_id = players[(i-1) % num_players].id
        player.right_id = players[(i+1) % num_players].id
        i += 1

    db_committing_function(p=players)


def play_card_with_trade(card, player, is_discarded, for_wonder, process_with_trade, no_prereq=False):
    """
    :param card: Card to be played
    :param player: Player object
    :param is_discarded: True if discarding
    :param for_wonder: True if using card to build wonder
    :param process_with_trade: True if user has confirmed to use trade for this card
    :param no_prereq: True if it is a free card (wonder special ability)
    :return: A variant of default_false or default_true
    """

    default_false = {'left': {'cost': 0}, 'right': {'cost': 0}, 'possible': False, 'message': None}
    default_true = {'left': {'cost': 0}, 'right': {'cost': 0}, 'possible': True, 'message': None}

    if is_discarded:
        player.money += 3
    else:
        if for_wonder:
            if player.wonder == "The Mausoleum of Halicarnassus" and not get_all_discarded_cards(player):
                default_false['message'] = 'Sorry, there were no cards in the discard pile - wonder was not played'
                return default_false
            card = get_wonder_card(player)
            if not card:
                default_false['message'] = 'You have already finished building your wonder. It is already perfect!'
                return default_false

        if no_prereq:
            default_true['message'] = 'You have had a free card ability - used for the {} card!'.format(card.name)
            update_player_object(card, player, for_wonder=for_wonder)
            stats = default_true
        else:
            stats = check_move_and_trade(card, player)
            price = stats['left']['cost'] + stats['right']['cost']

            # Play card with no cost
            if stats['possible'] and price == 0:
                if not stats['message']:
                    stats['message'] = '{} successfully played'.format(card.name)

            # Play card with trade confirmed
            elif stats['possible'] and process_with_trade:
                stats['message'] = '{} played by buying {} coin worth of goods'.format(card.name, price)

                # Pay for trade
                player.money -= (stats['left']['cost'] + stats['right']['cost'])
                player_left = get_player(player.left_id)
                player_left.money += stats['left']['cost']
                player_right = get_player(player.right_id)
                player_right.money += stats['right']['cost']
                db_committing_function(player_left, player_right)

            # Card needs trade to play, send to user for confirmation (this is the only one without messages)
            elif stats['possible']:
                return stats

            # Card cannot be played
            else:
                return stats

            # Play card
            update_player_object(card, player, for_wonder=for_wonder)

        """
        if for_wonder and player.wonder == "The Mausoleum of Halicarnassus":
            game = get_game(player=player)
            game.waiting_for_discard = True
            db_committing_function(game)
        """

        default_true = stats

    history = Cardhist(playerId=player.id, cardId=card.id, discarded=is_discarded, for_wonder=for_wonder,
                       card_name=card.name, card_colour=card.colour)
    db_committing_function(player, history)
    return default_true


def swap_hands(card, player, game):
    # UPDATE DB
    old_round_cardId = [c.id for c in get_cards(player)]
    #print("Cards in hand", old_round_cardId, "    Card trying to remove:", card.id, card.name)
    old_round_cardId.remove(card.id)

    rounds = []
    for unplayed_card in old_round_cardId:
        rounds.append(
            Round(playerId=get_next_player_id(player, game.age), age=game.age, round=game.round + 1,
                  cardId=unplayed_card))

    db_committing_function(r=rounds)


def update_player_object(card, player, for_wonder=False):
    """Helper function for process_card"""
    if card.resourceAlternating:
        player.extra_brick += card.giveBrick
        player.extra_ore += card.giveOre
        player.extra_wood += card.giveWood
        player.extra_stone += card.giveStone
        player.extra_paper += card.givePaper
        player.extra_cloth += card.giveCloth
        player.extra_glass += card.giveGlass
    else:
        player.brick += card.giveBrick
        player.ore += card.giveOre
        player.wood += card.giveWood
        player.stone += card.giveStone
        player.paper += card.givePaper
        player.cloth += card.giveCloth
        player.glass += card.giveGlass

    player.military += card.giveMilitary
    player.points += card.givePoints
    player.money += card.giveMoney - card.costMoney

    if for_wonder:
        player.wonder_level += 1

    if card.giveResearch:
        research_calcs(card, player)

    if card.colour == 'wonder':
        if card.name == 'zeus_1':
            player.left_cheap_trade = True
            player.right_cheap_trade = True

        elif card.name == 'babylon_2':
            player.play_twice = True
    elif card.colour == 'grey':
        player.grey += 1
    elif card.colour == 'red':
        player.red += 1
    elif card.colour == 'green':
        player.green += 1
    elif card.colour == 'purple':
        player.purple += 1
    elif card.colour == 'blue':
        player.blue += 1
    elif card.colour == 'brown':
        player.brown += 1
    elif card.colour == 'yellow':
        player.yellow += 1
        left_player = get_player(player.left_id)
        left_player_cards = get_cards(player=left_player, history=True)
        cards = get_cards(player=player, history=True)
        right_player = get_player(player.right_id)
        right_player_cards = get_cards(player=right_player, history=True)

        if card.name == 'East Trading Post':
            player.right_cheap_trade = True

        elif card.name == 'West Trading Post':
            player.left_cheap_trade = True

        elif card.name == 'Marketplace':
            player.advanced_cheap_trade = True

        elif card.name == 'Vineyard':
            player.money += len([x for x in left_player_cards if x.colour == 'brown'])
            player.money += len([x for x in cards if x.colour == 'brown'])
            player.money += len([x for x in right_player_cards if x.colour == 'brown'])

        elif card.name == 'Bazaar':
            player.money += len([x for x in left_player_cards if x.colour == 'grey']) * 2
            player.money += len([x for x in cards if x.colour == 'grey']) * 2
            player.money += len([x for x in right_player_cards if x.colour == 'grey']) * 2

        elif card.name == 'Arena':
            player.money += 3 * player.wonder_level

        elif card.name == 'Lighthouse':
            player.money += len([x for x in cards if x.colour == 'yellow']) + 1

        elif card.name == 'Haven':
            player.money += len([x for x in cards if x.colour == 'brown'])

        elif card.name == 'Chamber of Commerce':
            player.money += len([x for x in cards if x.colour == 'grey']) * 2


def end_game_cards(player, cards):
    left_player = get_player(player.left_id)
    left_player_cards = get_cards(player=left_player, history=True)
    right_player = get_player(player.right_id)
    right_player_cards = get_cards(player=right_player, history=True)

    for card in cards:

        if card.colour == 'yellow':
            if card.name == 'Arena':
                player.points += player.wonder_level

            elif card.name == 'Lighthouse':
                player.points += len([x for x in cards if x.colour == 'yellow'])

            elif card.name == 'Haven':
                player.points += len([x for x in cards if x.colour == 'brown'])

            elif card.name == 'Chamber of Commerce':
                player.points += len([x for x in cards if x.colour == 'grey']) * 2

        elif card.colour == 'purple':
            if card.name == 'Workers Guild':
                player.points += len([x for x in left_player_cards if x.colour == 'brown'])
                player.points += len([x for x in right_player_cards if x.colour == 'brown'])

            elif card.name == 'Craftsmens Guild':
                player.points += len([x for x in left_player_cards if x.colour == 'grey']) * 2
                player.points += len([x for x in right_player_cards if x.colour == 'grey']) * 2

            elif card.name == 'Traders Guild':
                player.points += len([x for x in left_player_cards if x.colour == 'yellow'])
                player.points += len([x for x in right_player_cards if x.colour == 'yellow'])

            elif card.name == 'Magistrates Guild':
                player.points += len([x for x in left_player_cards if x.colour == 'blue'])
                player.points += len([x for x in right_player_cards if x.colour == 'blue'])

            elif card.name == 'Philosophers Guild':
                player.points += len([x for x in left_player_cards if x.colour == 'green'])
                player.points += len([x for x in right_player_cards if x.colour == 'green'])

            elif card.name == 'Spies Guild':
                player.points += len([x for x in left_player_cards if x.colour == 'red'])
                player.points += len([x for x in right_player_cards if x.colour == 'red'])

            elif card.name == 'Shipowners Guild':
                player.points += len([x for x in cards if x.colour == 'brown'])
                player.points += len([x for x in cards if x.colour == 'grey'])
                player.points += len([x for x in cards if x.colour == 'purple'])

            elif card.name == 'Builders Guild':
                player.points += left_player.wonder_level + player.wonder_level + right_player.wonder_level

            elif card.name == 'Strategists Guild':
                player.points += left_player.military_loss + right_player.military_loss


def increment_game_round(game_info, players):
    """Helper function to process_card, changes round"""
    if game_info.waiting_for_discard:
        #print("Waiting for Halicarnassus to play discard")
        return

    game_info.round += 1
    db_committing_function(game=game_info)

    if game_info.round == 7:
        age_calcs_and_dealing(players, game_info)


def military_calcs(players, age):
    if age is 1:
        win = 1
    elif age is 2:
        win = 3
    elif age is 3:
        win = 5

    for player in players:
        left_player = list(filter(lambda p: p.id == player.left_id, players))[0]
        right_player = list(filter(lambda p: p.id == player.right_id, players))[0]
        if player.military > left_player.military:
            player.points += win
        elif player.military < left_player.military:
            player.points -= 1
            player.military_loss += 1

        if player.military > right_player.military:
            player.points += win
        elif player.military < right_player.military:
            player.points -= 1
            player.military_loss += 1


def research_calcs(card, player):
    """Updates points given by research - computes difference between old and new points"""
    old_points = research_helper(player)

    if card.giveResearch == 'cog':
        player.cog += 1
    elif card.giveResearch == 'tablet':
        player.tablet += 1
    elif card.giveResearch == 'compass':
        player.compass += 1
    elif card.giveResearch == 'wildcard':
        player.wildcard += 1

    new_points = research_helper(player)
    player.points += new_points - old_points


def research_helper(player):
    """Called by research_calcs
    Returns an int representing points attributed to research cards"""
    research = [player.cog, player.tablet, player.compass]

    if player.wildcard > 0:
        # Searches for optimal use of wildcard
        points = []
        research_helpers_rec_search(points, player.wildcard, research)
        return max(points, default=0)
    else:
        return min(research) * 7 + sum([r * r for r in research])


def research_helpers_rec_search(points, wildcards, research):
    """Searches optimal combination of wildcards with existing research cards
    Populates points list with results which research_helper uses"""
    if wildcards is 0:
        points.add(min(research) * 7 + sum([r * r for r in research]))
        return

    new_research = copy.deepcopy(research)

    for j in range(wildcards):
        for i in range(len(research)):
            new_research[i] += 1
            wildcards -= 1
            research_helpers_rec_search(points, wildcards, new_research)

            # Roll back changes
            wildcards += 1
            new_research[i] -= 1
