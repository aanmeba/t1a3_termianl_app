class Calculator

    def initialize(array, bill)
        @array = array
        @no_of_ppl = @array.length
        @bill = bill
    end
    
    def split_equally(num, bill)
        return bill / num
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
            temp = new_array[another_ran_num]
            temp += reminder
            new_array.delete_at(another_ran_num)
            new_array.insert(another_ran_num, temp)
        end                
        return new_array        
    end

    def split_manually(array, bill)
        each_amount = []
        index = 0
        while index < array.length
            puts "#{index+1}. #{array[index]}"
            each = gets.chomp.to_f          
            if each <= bill && each >= 0
                each_amount << each
                puts "Rest: #{bill - each_amount.sum}"
                index += 1
            else 
                puts "Please enter the valid amount"
                each_amount = []
                index = 0
            end

            # validation
            if index == array.length
                if each_amount.sum != bill
                    puts "Pleasse enter the valid amount"
                    each_amount = []
                    index = 0
                else
                    puts "check check, #{each_amount}."
                    break
                end
            end
        end
        return each_amount
    end

    def display_equally(array, value)
        puts "==========================="
        array.each_with_index {|name, index| puts "#{index + 1}. #{name.capitalize}: $#{value.round(2)}"}
        puts "--------------------"
        puts "Total: #{array.length * value}"
        puts "==========================="
    end

    def display_randomly_manually(array1, array2)
        puts "==========================="
        array1.each_with_index {|name, index| puts "#{index + 1}. #{name.capitalize}: $#{array2[index].round(2)}"}
        puts "--------------------"
        puts "Total: #{array2.sum}"
        puts "==========================="
    end
end
