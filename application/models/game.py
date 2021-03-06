from index import db

class Game(db.Model):
    __tablename__ = 'game'
    id = db.Column(db.Integer(), primary_key=True)
    age = db.Column(db.Integer(), default=0)
    round = db.Column(db.Integer(), default=1)
    started = db.Column(db.Boolean(), default=False)
    complete = db.Column(db.Boolean(), default=False)
    single_player = db.Column(db.Boolean(), default=False)
    waiting_for_discard = db.Column(db.Boolean(), default=False)

    def serialise(self):
        return {
            'id':self.id,
            'age':self.age,
            'round':self.round,
            'started':self.started,
            'complete':self.complete,
            'single_player':self.single_player,
            'waiting_for_discard':self.waiting_for_discard
        }
