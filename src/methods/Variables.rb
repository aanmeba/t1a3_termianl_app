
# Class for variables to use across files
class Variables
    attr_reader :instruction, :highlight, :err_msg

    def initialize
        @instruction = :light_blue
        @highlight = :light_red
        @err_msg = ">>".colorize(@highlight)
    end    
end