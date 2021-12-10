# def options
    
# end

class Calculator

    def initialize(num, bill)
        @num = num
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
        pp rand_array

        # if the value is floating number, the final sum will be less than total bill
        sum_rand_array = rand_array.sum
        pp "sum: #{sum_rand_array}"
        # each_value = (bill / sum_rand_array).round(1)
        reminder = bill % sum_rand_array
            # [0,0,0] => error
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

    pp split_randomly(3, 98.00)
end
