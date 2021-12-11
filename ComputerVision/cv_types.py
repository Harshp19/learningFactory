import enum

class colors(enum.Enum):
    #command 0-4 is for user
    BLUE = 0
    RED = 1
    WHITE = 2
    BLACK = 3
    ALL_COLOR = 4
    EMPTY_ERR = 5
    NONE_ERR = 6

class shape(enum.Enum):
    #command 0-4 is for user
    CIRCLE = 0
    TRIANGLE = 1
    V_SHAPE = 2
    SQUARE = 3
    ALL_SHAPE = 4
    NONE_ERR = 5
