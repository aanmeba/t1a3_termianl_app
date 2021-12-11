
require 'tty-prompt'


class Calculator

    def initialize(array, bill)
        @array = array
        @no_of_ppl = @array.length
        @bill = bill
    end
    
    def split_equally(num, bill)
        # reminder = bill % num
        # if reminder == 0.0
        #     result = bill / num
        #     return result
        # else
        #     reminder % num
        result_array = []
        each_amount = (bill / num).round(2)
        i = 0
            while i < num
                result_array << each_amount
                i += 1    
            end
            
        if (each_amount * num) != bill
            leftover = bill - (each_amount * num)
            ran_num = rand(0..num-1)
            result_array[ran_num] += leftover
            # temp += leftover
        end            
            
        return result_array
    end

    def pick_random_num(num)
        rand_array = num.times.map { rand(num) }
        return rand_array
    end   

    def split_randomly(num, bill)
        rand_array = pick_random_num(num)

        # rand_array validation - [0, 0, 0] cause errors
        if rand_array.each {|item| item == 0}
            rand_array = pick_random_num(num)
        end

        sum_rand_array = rand_array.sum        
        reminder = bill % sum_rand_array

        # if there is a reminder, subtract it from the bill then calculate the rest
        each_value = (bill - reminder)/sum_rand_array

        # generate a new array including split values
        new_array = rand_array.map {|i| 
            i * each_value.round(1) 
        }

        # if there is a reminder, pick another random number 
        # then add the reminder to the corresponding index of the new array
        if reminder != 0.0
            another_ran_num = rand(0..num-1)
            new_array[another_ran_num] += reminder
            # temp += reminder
            # new_array.delete_at(another_ran_num)
            # new_array.insert(another_ran_num, temp)
        end                
        return new_array        
    end

    def split_manually(array, bill)
        each_amount = []
        index = 0
        
        prompt = TTY::Prompt.new

        while index < array.length

            puts "Total amount: #{bill}"
            each = prompt.ask("How much is #{array[index].capitalize} going to pay?".colorize(:light_blue), required: true, convert: :float) do |q|
                q.validate(/^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$/)
                q.messages[:valid?] = "Please provide positive numbers"
                q.modify :chomp
                q.messages[:convert?] = "Please provide positive numbers"
            end

            each = each.round(2)

            # puts "#{index+1}. #{array[index]}"
            # each = gets.chomp.to_f          
            if each <= bill && each >= 0
                each_amount << each
                rest = (bill - each_amount.sum).round(2)
                puts "#{index} / #{array.length - 1}"
                puts "Rest: #{rest}"
                index += 1
            else 
                puts "Please enter the valid amount"
                each_amount = []
                index = 0
            end

            if index == array.length - 1
                each_amount << rest
                break
            end
            # validation
            # if index == array.length
            #     if each_amount.sum != bill
            #         puts "Pleasse enter the valid amount"
            #         each_amount = []
            #         index = 0
            #     else
            #         puts "check check, #{each_amount}."
            #         break
            #     end
            # end
        end
        return each_amount
    end

    def display_equally(array, value)
        puts "==========================="
        array.each_with_index {|name, index| puts "#{index + 1}. #{name.capitalize}: $#{value.round(3)}"}
        puts "--------------------"
        puts "Total: #{array.length * value}"
        puts "==========================="
    end

    def display_randomly_manually(array1, array2)
        puts "==========================="
        array1.each_with_index {|name, index| puts "#{index + 1}. #{name.capitalize}: $#{array2[index].round(2)}"}
        puts "--------------------"
        puts "Total: #{array2.sum.round(2)}"
        puts "==========================="
    end
end
