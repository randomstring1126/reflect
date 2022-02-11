function split(input)
	local words = {}
	for word in input:gmatch("%S+") do
		if string.sub(word, 1, 1) == '"' then
			quoted = true
		end

		if string.sub(word, #word) == '"' then
			quoted = false
			sentence = sentence .. " " .. word:sub(1, -2)
			table.insert(words, sentence)
			sentence = nil
		elseif quoted and sentence then
			sentence = sentence .. " " .. word
		elseif quoted and not sentence then
			sentence = word:sub(2)
		else
			table.insert(words, word:lower())
		end
	end
	return words
end

string = [[hello "e a t" llll]]
bs = split(string)

for i = 1, #bs do
	print(bs[i])
end
