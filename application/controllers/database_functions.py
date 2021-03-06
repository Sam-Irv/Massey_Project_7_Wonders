from index import db
from ..models.user import User
from ..models.card import Card
from ..models.player import Player
from ..models.game import Game
from ..models.cardhist import Cardhist
from ..models.round import Round
from ..models.wonder import Wonder


def get_wonder_card(player):
    """Logic for processing a turn where a wonder is built"""
    wonder = Wonder.query.filter_by(name=player.wonder).first()

    # Makes sure a wonder is not played when it is already maxed out
    if wonder.slots is player.wonder_level:
        return False

    # Finds wonder card and returns it
    if player.wonder_level == 0:
        card = Card.query.filter_by(name=wonder.card_1).first()
    elif player.wonder_level == 1:
        card = Card.query.filter_by(name=wonder.card_2).first()
    elif player.wonder_level == 2:
        card = Card.query.filter_by(name=wonder.card_3).first()
    else:
        card = Card.query.filter_by(name=wonder.card_4).first()

    return card


def get_all_wonder_cards(player):
    """Used for AI decision making. Returns all wonder cards"""
    wonder = Wonder.query.filter_by(name=player.wonder).first()
    names = [wonder.card_1, wonder.card_2, wonder.card_3, wonder.card_4]
    return db.session.filter(Card.name.in_(names)).all()


def get_card(card_id):
    return Card.query.filter_by(id=card_id).first()


def get_all_discarded_cards(player):
    players = get_players(player=player)

    # Get round 7 cards
    card_ids = []

    # Get all discarded cards
    for p in players:
        card_ids += [x.cardId for x in get_card_history(p) if x.discarded]
        card_ids += [x.cardId for x in Round.query.filter_by(playerId=p.id, round=7).all()]

    # Take out any discarded cards that have already been played
    for p in players:
        if p.wonder == 'The Hanging Gardens of Babylon' or p.wonder == 'The Mausoleum of Halicarnassus':
            hist = [x.cardId for x in get_card_history(p) if not x.discarded and x.cardId in card_ids]
            for remove_id in hist:
                card_ids.remove(remove_id)
    return Card.query.filter(Card.id.in_(card_ids)).all()


def get_cards(player=None, game=None, card_ids=None, history=False):
    """
    For historical cards played, provide player and history=True - filters out discarded cards
    If card_ids already available, supply only that
    If game available, supply that in addition to player (optional)
    Returns all cards in current hand, or cards played in the past
    
    If discarded=True and player supplied, return all discarded cards minus any that have been later played
    """

    if history:
        card_ids = [x.cardId for x in get_card_history(player) if not x.discarded]
        if not card_ids:
            return []

    if card_ids:
        return Card.query.filter(Card.id.in_(card_ids)).all()
    elif player:
        if not game:
            game = get_game(player=player)

        card_ids = [card[0] for card in db.session.query(Round.cardId).filter_by(playerId=player.id, age=game.age,
                                                                                 round=game.round).all()]
        if not card_ids:
            return []
        else:
            return Card.query.filter(Card.id.in_(card_ids)).all()


def get_card_history(player):
    return Cardhist.query.filter_by(playerId=player.id).all()


def get_game(game_id=None, player=None):
    if game_id:
        return Game.query.filter_by(id=game_id).first()
    elif player:
        return Game.query.filter_by(id=player.gameId).first()


def get_player(player_id):
    return Player.query.filter_by(id=player_id).first()


def get_players(game_id=None, player=None):
    if game_id:
        return Player.query.filter_by(gameId=game_id).all()
    elif player:
        return Player.query.filter_by(gameId=player.gameId).all()


def db_committing_function(*args, **kwargs):
    try:
        for value in args:
            if type(value) is list:
               db.session.add_all(value)
            else:
               db.session.add(value)
        for key, value in kwargs.items():
            if type(value) is list:
               db.session.add_all(value)
            else:
               db.session.add(value)
        db.session.commit()
    except Exception as e:
        print('Error committing database update')
        print(e)
