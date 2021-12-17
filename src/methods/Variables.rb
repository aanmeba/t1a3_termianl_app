
# Class for variables for colour values to use across files

class Variables
    attr_reader :instruction, :highlight, :err_msg

    def initialize
        @instruction = :light_blue
        @highlight = :light_red
        @err_msg = ">>".colorize(@highlight)
    end    
end

# Class for tty-table border
# class MyBorder < TTY::Table::Border
#     def_border do
#         top         "=".colorize(Variable.instruction)
#         center       "|".colorize(Variable.instruction)
#         bottom       "=".colorize(Variable.instruction)
#         mid          "-".colorize(:light_red)
#         # mid_mid      " "
#     end
# end