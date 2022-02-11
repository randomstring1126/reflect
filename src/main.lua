local sql = require "sqlite3"
local db = sql.open("test.db")
local cli = {}
local core = {}

function core.quit()
	db:close()
	os.exit()
end

function core.add(input)
	if input[2] == "book" then
		local stm = db:prepare("INSERT INTO books (title, author) VALUES(?, ?)")
		stm:bind(input[3], input[4])
		stm:exec()
	elseif input[2] == "member" then
		-- more stuff
	end
end

-- Function that splits a sentence into words
function cli.split(input)
	local words = {}
	for word in input:gmatch("%S+") do
		table.insert(words, word:lower())
	end
	return words
end

function cli.parser(input)
	if input[1] == "quit" then
		core.quit()
	end

	if input[1] == "add" then
		core.add(input)
	end
end

-- Creating the Members and Books tables if they do not already exist
db:exec("CREATE TABLE IF NOT EXISTS members (id integer primary key autoincrement, fname TEXT, lname TEXT)")
db:exec("CREATE TABLE IF NOT EXISTS books   (id integer primary key autoincrement, title TEXT, author TEXT)")

function main()
	io.write("> ")
	local input = io.read()
	local input = cli.split(input)
	cli.parser(input)

	return main()
end
main()
