
require 'tty-prompt'


class Calculator
    attr_reader :array, :no_of_ppl, :bill
    
    def initialize(array, bill)
        @array = array
        @no_of_ppl = @array.length
        @bill = bill
    end
    
    def split_equally
        result_array = []
        each_amount = (@bill / @no_of_ppl).round(2)
        i = 0
            while i < @no_of_ppl
                result_array << each_amount
                i += 1    
            end
            
        if (each_amount * @no_of_ppl) != @bill
            leftover = @bill - (each_amount * @no_of_ppl)
            ran_num = rand(0..@no_of_ppl-1)
            result_array[ran_num] += leftover
            # temp += leftover
        end            
            
        return result_array
    end

    def pick_random_num
        rand_array = @no_of_ppl.times.map { rand(@no_of_ppl) }
        return rand_array
    end   

    def split_randomly
        rand_array = self.pick_random_num

        # rand_array validation - [0, 0, 0] cause errors
        if rand_array.each {|item| item == 0}
            rand_array = self.pick_random_num
        end

        sum_rand_array = rand_array.sum        
        reminder = @bill % sum_rand_array

        # if there is a reminder, subtract it from the bill then calculate the rest
        each_value = (@bill - reminder)/sum_rand_array

        # generate a new array including split values
        new_array = rand_array.map {|i| 
            i * each_value.round(1) 
        }

        # if there is a reminder, pick another random number 
        # then add the reminder to the corresponding index of the new array
        if reminder != 0.0
            another_ran_num = rand(0..@no_of_ppl-1)
            new_array[another_ran_num] += reminder
        end                
        return new_array        
    end

    def split_manually
        each_amount = []
        index = 0
        
        prompt = TTY::Prompt.new

        while index < @no_of_ppl

            puts "Total amount: #{@bill} | Number of people: #{index+1} / #{@no_of_ppl - 1}"
            each = prompt.ask("How much is #{@array[index].capitalize} going to pay?".colorize(:light_blue), required: true, convert: :float) do |q|
                q.validate(/^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$/)
                q.messages[:valid?] = "Please provide positive numbers"
                q.modify :chomp
                q.messages[:convert?] = "Please provide positive numbers"
            end

            each = each.round(2)
    
            if each <= @bill && each >= 0
                each_amount << each
                rest = (@bill - each_amount.sum).round(2)
                puts "Rest: #{rest}"
                index += 1
            else 
                puts "Please enter the valid amount"
                each_amount = []
                index = 0
            end

            if index == @no_of_ppl - 1
                each_amount << rest
                break
            end
        end
        return each_amount
    end

    def display(result_array)
        puts "==========================="
        @array.each_with_index {|name, index| puts "#{index + 1}. #{name.capitalize}: $#{result_array[index].round(2)}"}
        puts "--------------------"
        puts "Total: #{result_array.sum.round(2)}"
        puts "==========================="
    end
end
