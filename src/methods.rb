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

        # if the value is floating number, the final sum will be less than total bill
        sum_rand_array = rand_array.sum
        # pp "sum: #{sum_rand_array}"
        
        reminder = bill % sum_rand_array
        each_value = (bill - reminder)/sum_rand_array
        
        pp "each value: #{each_value}, rest: #{reminder}"
        
        new_array = rand_array.map {|i| 
            i * each_value.round(1) 
        }

        if reminder != 0.0
            another_ran_num = rand(0..num-1)
            pp "another ran num: #{another_ran_num}"
            temp = new_array[another_ran_num]
            temp += reminder
            pp temp
            pp new_array.delete_at(another_ran_num)
            pp new_array.insert(another_ran_num, temp)
        end

        pp "total bill: #{bill}, total division: #{new_array.sum}"
                
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
                puts "#{array} --- #{each_amount}"
                puts "#{index} / #{array.length - 1}"
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
                    puts "#{index} / #{array.length - 1}"
                    puts "#{array} --- #{each_amount}"
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

    def display_randomly(array1, array2)
        puts "==========================="
        array1.each_with_index {|name, index| puts "#{index + 1}. #{name.capitalize}: $#{array2[index].round(2)}"}
        puts "--------------------"
        puts "Total: #{array2.sum}"
        puts "==========================="
    end
end
