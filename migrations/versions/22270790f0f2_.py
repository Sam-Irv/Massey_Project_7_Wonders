"""empty message

Revision ID: 22270790f0f2
Revises: 68874dfa9e3e
Create Date: 2017-08-10 17:32:51.275918

"""

# revision identifiers, used by Alembic.
revision = '22270790f0f2'
down_revision = '68874dfa9e3e'

from alembic import op
import sqlalchemy as sa


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('card',
    sa.Column('name', sa.String(length=50), nullable=False),
    sa.Column('noPlayers', sa.Integer(), nullable=False),
    sa.Column('age', sa.Integer(), nullable=True),
    sa.Column('type', sa.String(length=10), nullable=True),
    sa.Column('costMoney', sa.Integer(), nullable=True),
    sa.Column('costWood', sa.Integer(), nullable=True),
    sa.Column('costBrick', sa.Integer(), nullable=True),
    sa.Column('costOre', sa.Integer(), nullable=True),
    sa.Column('costStone', sa.Integer(), nullable=True),
    sa.Column('costGlass', sa.Integer(), nullable=True),
    sa.Column('costPaper', sa.Integer(), nullable=True),
    sa.Column('costCloth', sa.Integer(), nullable=True),
    sa.Column('giveWood', sa.Integer(), nullable=True),
    sa.Column('giveBrick', sa.Integer(), nullable=True),
    sa.Column('giveOre', sa.Integer(), nullable=True),
    sa.Column('giveStone', sa.Integer(), nullable=True),
    sa.Column('giveGlass', sa.Integer(), nullable=True),
    sa.Column('givePaper', sa.Integer(), nullable=True),
    sa.Column('giveCloth', sa.Integer(), nullable=True),
    sa.Column('givePoints', sa.Integer(), nullable=True),
    sa.Column('giveMilitary', sa.Integer(), nullable=True),
    sa.Column('giveMoney', sa.Integer(), nullable=True),
    sa.PrimaryKeyConstraint('name', 'noPlayers')
    )
    op.create_table('player',
    sa.Column('gameId', sa.Integer(), nullable=False),
    sa.Column('userId', sa.Integer(), nullable=False),
    sa.Column('ready', sa.Boolean(), nullable=True),
    sa.Column('wood', sa.Integer(), nullable=True),
    sa.Column('brick', sa.Integer(), nullable=True),
    sa.Column('ore', sa.Integer(), nullable=True),
    sa.Column('stone', sa.Integer(), nullable=True),
    sa.Column('glass', sa.Integer(), nullable=True),
    sa.Column('paper', sa.Integer(), nullable=True),
    sa.Column('cloth', sa.Integer(), nullable=True),
    sa.Column('points', sa.Integer(), nullable=True),
    sa.Column('military', sa.Integer(), nullable=True),
    sa.Column('money', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['gameId'], ['game.id'], ),
    sa.ForeignKeyConstraint(['userId'], ['user.id'], ),
    sa.PrimaryKeyConstraint('gameId', 'userId')
    )
    op.create_table('round',
    sa.Column('age', sa.Integer(), nullable=False),
    sa.Column('round', sa.Integer(), nullable=False),
    sa.Column('userId', sa.Integer(), nullable=False),
    sa.Column('gameId', sa.Integer(), nullable=False),
    sa.Column('cardName', sa.String(length=50), nullable=False),
    sa.Column('cardNoPlayers', sa.Integer(), nullable=False),
    sa.ForeignKeyConstraint(['cardName', 'cardNoPlayers'], ['card.name', 'card.noPlayers'], ),
    sa.ForeignKeyConstraint(['userId', 'gameId'], ['player.userId', 'player.gameId'], ),
    sa.PrimaryKeyConstraint('age', 'round', 'userId', 'gameId', 'cardName', 'cardNoPlayers')
    )
    op.add_column('game', sa.Column('round', sa.Integer(), nullable=True))
    op.drop_constraint('user_game_id_fkey', 'user', type_='foreignkey')
    op.drop_column('user', 'game_id')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('user', sa.Column('game_id', sa.INTEGER(), autoincrement=False, nullable=True))
    op.create_foreign_key('user_game_id_fkey', 'user', 'game', ['game_id'], ['id'])
    op.drop_column('game', 'round')
    op.drop_table('round')
    op.drop_table('player')
    op.drop_table('card')
    # ### end Alembic commands ###
