
# Command line arguments

if ARGV.length > 0
    flag, *rest = ARGV 
    ARGV.clear
    case flag
    when '-help', '-h'
        puts
        puts "----------------------------------------------------".colorize(Variable.instruction)
        puts " Split The Bill ".colorize(:black).on_light_blue
        puts "This is an application for dividing a bill."
        puts
        puts "There are three options: split the bill 1) Randomly, 2) Equally, 3) Manually."
        puts
        puts "1) Randomly".colorize(Variable.instruction)
        puts "Are you feeling lucky? Why don't you try this option. It divides the bill in random manner."
        puts "If your bill is $99 and you are going to split it with two others, the result can be $90, $9, and $0!"
        puts
        puts "2) Equally".colorize(Variable.instruction)
        puts "If you want to split the bill quickly and evenly, please try this option."
        puts "Note: If the bill cannot be evenly divided,\s\nit picks a random person and adds the remainder to the person."
        puts
        puts "3) Manually".colorize(Variable.instruction)
        puts "If you want to pay a specific amount, why don't you try this option."
        puts "You can enter how much each one of you is going to pay."
        puts 
        puts "----------------------------------------------------".colorize(Variable.instruction)
        puts
        exit
    when '-info', '-i'
        puts
        puts "----------------------------------------------------".colorize(Variable.instruction)
        puts " Split The Bill ".colorize(:black).on_light_blue
        puts "This program is safely running:" 
        puts
        puts "- Ruby #{RUBY_VERSION}"
        puts "- WSL: Ubuntu-20.04"
        puts "- Windows 10"
        puts
        puts "If you have any trouble to use this application,\s\nplease feel free to contact me here:\s\ngcas022106@coderacademy.edu.au."
        puts "----------------------------------------------------".colorize(Variable.instruction)
        puts
        exit
    else
        puts
        puts "----------------------------------------------------".colorize(Variable.instruction) 
        puts "Sorry, that's invalid argument."
        puts "Available options are: -help / -h, -info / -i"
        puts "----------------------------------------------------".colorize(Variable.instruction)
        puts
        exit
    end 
end