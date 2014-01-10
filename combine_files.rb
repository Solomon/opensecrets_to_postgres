
def combine_files(new_filename, filename_array)
  File.open(new_filename, "w") do |combined_file|
    filename_array.each do |f|
      text = File.open(f, "r").read
      text.each_line do |line|
        combined_file << line
      end
    end
  end
end

# Combine all the groups except for individual contributions
# because they have two file types
def combine_non_individual
  file_groups = %w{pacs pac_other cmtes cands}

  file_groups.each do |g|
    puts "combining #{g}"
    files = Dir.entries('.').select{ |f| f[/^#{g}/] }
    filename = "combined_#{g}.txt"
    combine_files(filename, files)
  end
end

def combine_individual
  new_individual_files = ["indivs12.txt", "indivs14.txt"]
  old_individual_files = Dir.entries('.').select{|f| f[/^indivs/]}.select{|f| !new_individual_files.include?(f) }
  old_combined_filename = "old_individual_combined.txt"
  combine_files(old_combined_filename, old_individual_files)
end


