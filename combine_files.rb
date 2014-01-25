def combine_files(new_filename, filename_array)
  File.open(new_filename + ".txt", "w") do |combined_file|
    filename_array.each do |f|
      text = File.open(f, "r").read
      text.each_line do |line|
        combined_file << line
      end
    end
  end
  format_file(new_filename)
end

def format_file(new_filename)
  format_command = "iconv -f utf-8 -t utf-8 -c #{new_filename}.txt > #{new_filename}_formatted.txt"
  system(format_command)
  system("rm #{new_filename}.txt")
  system("mv -f #{new_filename}_formatted.txt #{new_filename}.txt")
end

def fix_file_formatting_errors
  system('sed -i ".original" -e "s/PREDKI, \|STANLEY/PREDKI, STANLEY/g" -e "s/THE \|HILLS/THE HILLS/g" -e "s/\|\|kirby, Rev Dr \|\|jerry/\|kirby, Rev Dr jerry/g" -e "s/MCCORMICK, GARY \|D/MCCORMICK, GARY D/g" -e "s/\|\|palmetto/|\palmetto/g" combined_old_individual.txt')
  system("mv -f combined_old_individual_new.txt combined_old_individual.txt")
end

# Combine all the groups except for individual contributions
# because they have two file types
def combine_non_individual
  file_groups = %w{pacs pac_other cmtes cands}

  file_groups.each do |g|
    puts "combining #{g}"
    files = Dir.entries('.').select{ |f| f[/^#{g}/] }
    filename = "combined_#{g}"
    combine_files(filename, files)
  end
end

def combine_individual
  new_individual_files = ["indivs12.txt", "indivs14.txt"]
  old_individual_files = Dir.entries('.').select{|f| f[/^indivs/]}.select{|f| !new_individual_files.include?(f) }
  old_combined_filename = "combined_old_individual"
  combine_files(old_combined_filename, old_individual_files)
  new_combined_filename = "combined_new_individual"
  combine_files(new_combined_filename, new_individual_files)
end

combine_non_individual
combine_individual
fix_file_formatting_errors
