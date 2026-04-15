require "json"
# Load saved game from json
class Load
  def load
    file_path = File.join(__dir__, "save.json")
    return nil unless File.exist?(file_path)

    JSON.parse(File.read(file_path))
  end
end
