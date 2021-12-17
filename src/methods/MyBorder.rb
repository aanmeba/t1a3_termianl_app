
# Class for tty-table border
class MyBorder < TTY::Table::Border
    def_border do
        top         "=".colorize(Variable.instruction)
        center       "|".colorize(Variable.instruction)
        bottom       "=".colorize(Variable.instruction)
        mid          "-".colorize(Variable.highlight)
    end
end