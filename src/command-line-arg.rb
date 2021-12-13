# Command line arguments

if ARGV.length > 0
    flag, *rest = ARGV 
    ARGV.clear
    case flag
    when '-help', '-h'
        puts
        puts "----------------------------------------------------".colorize($instruction)
        puts " Split The Bill ".colorize(:black).on_light_blue
        puts "This is an application for dividing a bill.\s\nIt provides three options: split the amount randomly, equally, and manually."
        puts
        puts "Note:".colorize($instruction) + " If the bill cannot be evenly divided,\s\nit picks a random person and adds the remainder to the person."
        puts "----------------------------------------------------".colorize($instruction)
        puts
        exit
    when '-info', '-i'
        puts
        puts "----------------------------------------------------".colorize($instruction)
        puts " Split The Bill ".colorize(:black).on_light_blue
        puts "This program is safely running:" 
        puts
        puts "- Ruby #{RUBY_VERSION}"
        puts "- WSL: Ubuntu-20.04"
        puts "- Windows 10"
        puts
        puts "If you have any trouble to use this application,\s\nplease feel free to contact me here:\s\ngcas022106@coderacademy.edu.au."
        puts "----------------------------------------------------".colorize($instruction)
        puts
        exit
    else
        puts
        puts "----------------------------------------------------".colorize($instruction) 
        puts "Invalid argument, please check the README file."
        puts "----------------------------------------------------".colorize($instruction)
        puts
        exit
    end 
end