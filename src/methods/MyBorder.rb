
# Class for tty-table border
class MyBorder < TTY::Table::Border
    def_border do
        top              "=".colorize(Variable.instruction)
        top_mid          "=".colorize(Variable.instruction)
        top_left         "=".colorize(Variable.instruction)
        top_right        "=".colorize(Variable.instruction)
        left             "|".colorize(Variable.instruction)
        right            "|".colorize(Variable.instruction)
        center           "|".colorize(Variable.instruction)
        bottom           "=".colorize(Variable.instruction)
        bottom_mid       "=".colorize(Variable.instruction)
        bottom_left      "=".colorize(Variable.instruction)
        bottom_right     "=".colorize(Variable.instruction)
        mid              "-".colorize(Variable.highlight)
        mid_mid          "-".colorize(Variable.highlight)
        mid_left         "-".colorize(Variable.highlight)
        mid_right        "-".colorize(Variable.highlight)
    end
end