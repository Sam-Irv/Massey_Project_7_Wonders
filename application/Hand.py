import psycopg2
import random
import application.Card as Card

# Probably better to get rid of the hand class once there is a better place for createHands()
class Hand:
    def createHands(self, numPlayers, age):
        query = ("SELECT cards.* FROM cards WHERE cards.age = %s"
                 " AND cards.number_of_players_for_first <= %s"
                 " UNION ALL SELECT cards.* FROM cards WHERE cards.age = %s"
                 " AND cards.number_of_players_for_second <= %s"
                 " UNION ALL SELECT cards.* FROM cards WHERE cards.age = %s"
                 " AND cards.number_of_players_for_third <= %s")

        # Database connection
        conn = psycopg2.connect("dbname='7-wonders' user='7-wonders.app' host='127.0.0.1' password=''")  # <----- TODO
        cursor = conn.cursor()
        cursor.execute(query, (age, numPlayers, age, numPlayers, age, numPlayers))
        table = cursor.fetchall

        # Create hands
        hands = []
        for player in numPlayers:
            hand = []
            for card in range(7): # Each loop takes a random card and adds it to the hand
                cardInfo = table.pop(random.random(len(table)))
                hand.append(Card(cardInfo[0], cardInfo[1], cardInfo[2]))
                # Include other information about costs and benefits
            hands.append(hand)
        return hands
