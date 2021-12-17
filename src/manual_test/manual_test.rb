# Manual test for error handling in .split_randomly
# Error: ZeroDivisionError in a specific situation

class Calculator
    attr_accessor :array
    attr_reader :no_of_ppl, :bill

    def initialize(array, bill)
        @array = array
        @no_of_ppl = @array.length
        @bill = bill
    end
        
    def pick_random_num
        rand_array = @no_of_ppl.times.map { rand(@no_of_ppl) }
        return rand_array
    end   

    def split_randomly
    
        # error handling - when pick_random_num returns all the elements are 0 in an array
        begin
            rand_array = self.pick_random_num
            pp rand_array
            puts "------"

            sum_rand_array = rand_array.sum      
            reminder = @bill % sum_rand_array    
        rescue ZeroDivisionError
            puts "Alert: ZeroDivisionError!!"
            retry
        end  

        each_value = (@bill - reminder)/sum_rand_array

        new_array = rand_array.map {|i| 
            i * each_value.round(1) 
        }

        if reminder != 0.0
            another_ran_num = rand(0..@no_of_ppl-1)
            new_array[another_ran_num] += reminder
        end                
        return new_array    
    end
end

test_one = Calculator.new(["amy", "winehouse"], 10)
# manual test - 1
# pp test_one.split_randomly

def string(array)
    names = []
    array.each { |name| names << name.split.map(&:capitalize!).join(' ') }
    return names
end

# manual test - 2
# pp string(["jungah ahn", "yejun park"])

# manual test - 3 - tty-table
require 'colorize'
require 'tty-table'
table = TTY::Table.new(header: [" Name ", " Amount "])
renderer = TTY::Table::Renderer::ASCII.new(table)

class MyBorder < TTY::Table::Border
    def_border do
        top         "=".colorize(:light_red)
        center       "|".colorize(:light_red)
        bottom       "=".colorize(:light_red)
        mid          "-".colorize(:light_red)
        # mid_mid      " "
    end
end

table << [" jungah ahn ", " $500 "]
table << [" jungah ahn ", " $500 "]
table << [" jungah ahn ", " $500 "]

puts table.render_with MyBorder
