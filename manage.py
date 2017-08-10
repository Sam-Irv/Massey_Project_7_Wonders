from flask_script import Manager
from flask_migrate import Migrate, MigrateCommand

from application.models.test_cards import db_load_test_cards
from application.app import app, db

migrate = Migrate(app, db)
manager = Manager(app)

# migrations
manager.add_command('db', MigrateCommand)


@manager.command
def create_db():
    """Creates the db tables."""
    db.drop_all()
    db.create_all()
    db_load_test_cards(app, db)

if __name__ == '__main__':
    manager.run()

