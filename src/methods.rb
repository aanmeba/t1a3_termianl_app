
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
        
        # error handling - when pick_random_num returns all the elements are 0 in an array
        begin
            rand_array = self.pick_random_num

            # rand_array validation - [0, 0, 0] cause errors
            # if rand_array.each {|item| item == 0}
            #     rand_array = self.pick_random_num
            # end

            sum_rand_array = rand_array.sum      
            reminder = @bill % sum_rand_array    
        rescue ZeroDivisionError
            retry
        end  
        
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

            puts "Total amount: #{@bill} | Number of people: #{index+1} / #{@no_of_ppl}"
            puts "----------------------------------------------".colorize($highlight)
            
            each = prompt.ask("How much is " + "#{@array[index].capitalize}".colorize($instruction) + " going to pay?", required: true, convert: :float) do |q|
                q.validate(/^(?:[0-9]\d*|0(?!(?:\.0+)?$))?(?:\.\d+)?$/)
                q.messages[:valid?] = "Please provide positive numbers"
                q.modify :chomp
                q.messages[:convert?] = "Please provide positive numbers"
            end
            system('clear')

            each = each.round(2)
        
            if (each_amount.sum + each) <= @bill 
                each_amount << each
                rest = (@bill - each_amount.sum).round(2)

                system('clear')
                puts "Rest: #{rest}"
                index += 1
            else 
                system('clear')
                puts $err_msg + " Please enter the valid amount"
                each_amount = []
                index = 0
            end

            if index == (@no_of_ppl - 1) || rest == 0.0
                each_amount << rest
                while each_amount.length != @no_of_ppl
                    each_amount << rest
                end

                system('clear')
                # confirm the input amount is correct. Otherwise, start it over
                each_amount.each_with_index do |amount, i|
                    puts "#{i+1}. #{@array[i].capitalize}: #{amount}"
                end

                yes_no_manually = prompt.yes?("Are you happy with it?") do |q|
                q.required true
                q.modify   :down
                end

                system('clear')
                case yes_no_manually
                when true
                    break
                when false
                    each_amount = []
                    index = 0
                end
            end
        end
        return each_amount
    end

    def display(result_array)
        puts "===========================".colorize($instruction)
        @array.each_with_index {|name, index| puts "#{index + 1}. #{name.capitalize}: $#{result_array[index].round(2)}"}
        puts "---------------------------".colorize($highlight)
        puts "Total: #{result_array.sum.round(2)}"
        puts "===========================".colorize($instruction)
    end
end
