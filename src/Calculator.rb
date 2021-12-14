
# Class containing calculation methods
class Calculator
    attr_reader :array, :no_of_ppl, :bill, :title
    # First param will be a name array that user input
    def initialize(array, bill, title)
        @array = array
        @no_of_ppl = @array.size
        @bill = bill
        @title = title
    end
    
    # Method to divide the bill evenly
    def split_equally
        result_array = []
        each_amount = (@bill / @no_of_ppl).round(2)

        # Pushes the each_amount to the result_array
        i = 0
        while i < @no_of_ppl
            result_array << each_amount
            i += 1    
        end

        # Error handling :
        # when the sum of the shares are not the same as @bill,
        # picks a random number and adds the amount of the gap
        # to the name which has the same number as an index
        sum_of_shares = (each_amount * @no_of_ppl)
        if sum_of_shares != @bill
            leftover = @bill - sum_of_shares
            ran_num = rand(0..@no_of_ppl-1)
            result_array[ran_num] += leftover
        end                        
        return result_array
    end

    # Method to pick an list of random number
    def pick_random_num
        rand_array = @no_of_ppl.times.map { rand(10) }
        return rand_array
    end   

    # Method to split the bill randomly
    def split_randomly        
        # Error handling :
        # when pick_random_num returns all the elements are 0 in an array
        begin
            rand_array = self.pick_random_num
            sum_rand_array = rand_array.sum
            # When sum_ran_array is 0, it will cause ZeroDivisonError
            remainder = @bill % sum_rand_array    
        rescue ZeroDivisionError
            # Invokes pick_random_num method again
            # until it generates valid array
            retry
        end  
        
        # If there is a remainder, 
        # subtract it from the bill then calculate the rest
        each_value = (@bill - remainder)/sum_rand_array

        # Generate a new array including split values
        new_array = rand_array.map { |i| i * each_value.round(1) }

        # If there is a remainder, pick another random number 
        # then add the remainder to the corresponding index of the new array
        if remainder != 0.0
            another_ran_num = rand(0..@no_of_ppl-1)
            new_array[another_ran_num] += remainder
        end                
        return new_array        
    end

    # Method to split the bill manually
    def split_manually
        each_amount = []
        index = 0
        rest = ""
        error_message = false
        # Displays the total amount and number of people 
        # to guide the user when entering the amount for each
        while index < @no_of_ppl
            heading(@title)
            # Displays an error message if the input is invalid
            if error_message
                puts $err_msg + " Please enter the valid amount"
            end

            if index == 0
                total_amount = "Total amount: #{@bill}"
            else
                total_amount = "Rest: #{rest}"
            end
            puts "#{total_amount} | Number of people: #{index+1} / #{@no_of_ppl}"
            puts "----------------------------------------------".colorize($highlight)
            
            prompt = TTY::Prompt.new

            each = prompt.ask("How much is " + "#{@array[index].capitalize}".colorize($instruction) + " going to pay?", required: true, convert: :float) do |q|
                q.validate(/^(?:[0-9]\d*|0(?!(?:\.0+)?$))?(?:\.\d+)?$/)
                q.messages[:valid?] = "Please provide positive numbers"
                q.modify :chomp
                q.messages[:convert?] = "Please provide positive numbers"
            end
            each = each.round(2)

            # Input validation
            # If user enter an amount that is above the total bill, it restarts
            if (each_amount.sum + each) <= @bill 
                each_amount << each
                rest = (@bill - each_amount.sum).round(2)
                error_message = false
                index += 1
            else 
                # A user enters invalid input
                # so the error message will show up
                error_message = true
                each_amount = []
                index = 0
                rest = ""
            end

            # Result validation
            # If the rest is 0.0, 
            # or the last person left after entering the amount for each, 
            # it calculates the rest and allocates it to the last person
            if index == (@no_of_ppl - 1) || rest == 0.0
                each_amount << rest
                # If the first person enters the same amount of the total bill,
                # the rest is going to be 0.0, 
                # and inserts it to the rest of people
                while each_amount.size != @no_of_ppl
                    each_amount << rest
                end
                
                heading(@title)
                # Confirms the input amount is correct. Otherwise, starts it over
                each_amount.each_with_index do |amount, i|
                    puts "#{i+1}. #{@array[i].capitalize}: #{amount}"
                end

                yes_no_manually = prompt.yes?("Are you happy with it?") do |q|
                    q.required true
                    q.modify   :down
                end
                case yes_no_manually
                when true
                    break
                when false
                    each_amount = []
                    index = 0
                    rest = ""
                end
            end
        end
        return each_amount
    end

    # Method to display the result
    # The second param is for calling the heading method
    def display(result_array)
        heading(@title)
        puts "===========================".colorize($instruction)
        @array.each_with_index {|name, index| puts "#{index + 1}. #{name.capitalize}: $#{result_array[index].round(2)}"}
        puts "---------------------------".colorize($highlight)
        puts "Total: #{result_array.sum.round(2)}"
        puts "===========================".colorize($instruction)
    end
end
