from index import db
from .game import Game
from .user import User


class Player(db.Model):
    __tablename__ = 'player'
    id = db.Column(db.Integer, primary_key=True)
    gameId = db.Column(db.Integer, db.ForeignKey('game.id'))
    userId = db.Column(db.Integer, db.ForeignKey('user.id'))
    ready = db.Column(db.Boolean, default=False)

    left_id = db.Column(db.Integer)
    right_id = db.Column(db.Integer)

    wood = db.Column(db.Integer, default=0)
    brick = db.Column(db.Integer, default=0)
    ore = db.Column(db.Integer, default=0)
    stone = db.Column(db.Integer, default=0)
    glass = db.Column(db.Integer, default=0)
    paper = db.Column(db.Integer, default=0)
    cloth = db.Column(db.Integer, default=0)
    points = db.Column(db.Integer, default=0)
    military = db.Column(db.Integer, default=0)
    money = db.Column(db.Integer, default=3)

    def serialise(self):
        return {
            'id':self.id,
            'gameId':self.gameId,
            'userId':self.userId,
            'ready':self.ready,
            'left_id':self.left_id,
            'right_id':self.right.id,
            'wood':self.wood,
            'brick':self.brick,
            'ore':self.ore,
            'stone':self.stone,
            'glass':self.glass,
            'paper':self.paper,
            'cloth':self.cloth,
            'points':self.points,
            'military':self.military,
            'money':self.money
        }