class Card:
  # Constrains properties cards can possess
  # All cards need a name, age, players, type (colour)
  def __init__ (self, name, type, age):
    self.name = name
    self.age = age
    self.type = type
    self.costMoney = 0
    self.requiresMaterial = {'Wood':0,
                         'Brick':0,
                         'Ore':0,
                         'Stone':0,
                         'Glass':0,
                         'Papyrus':0,
                         'Cloth':0}

    self.benefits = {'Points':0,
                     'Military':0,
                     'Money':0,
                     'Wood':0,
                     'Brick':0,
                     'Ore':0,
                     'Stone':0,
                     'Glass':0,
                     'Papyrus':0,
                     'Cloth':0}
    
    # Bonuses <- Future implementation
