require 'json'

input = JSON.parse(STDIN.read)
results = input['patterns'].map do |pattern|
  regex = Regexp.new(pattern['regex'])
  input['lines'].map do |line|
    match = regex.match(line)
    next nil unless match

    {
      start: line[0...match.begin(0)].encode('UTF-16LE').bytesize / 2,
      end: line[0...match.end(0)].encode('UTF-16LE').bytesize / 2,
      captures: match.to_a.map { |capture| capture || '' }
    }
  end
end
STDOUT.write(JSON.generate({ version: RUBY_VERSION, results: results }))
