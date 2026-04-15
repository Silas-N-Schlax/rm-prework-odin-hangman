require "json"
# Save game data to a .json file
class Save
  def save(data)
    json = JSON.generate(data)
    file_path = File.join(__dir__, "save.json")
    File.write(file_path, json)
  end
end
