local filename = "Books.tsv"
local file = io.open(filename, "r")
local books = {}
local Book = {title = "", author = "", year = ""}
local firstLine = {}
local index = 0

function Book:new(bt,title, author, year)
    bt = {}
    setmetatable(bt,self)
    bt.__index = self
    bt.title = title or "Book"
    bt.author = author or "John author"
    bt.year = year or "1776";
    return bt
end

function books:list_by(choice)
    print("You have".." "..index.." ".."books")
    print('\nWould you like all books listed by "title", "author", "year", or "all"? or would you like to "remove", "update", or "save" ? If you have 0 books run "load"')
    local choice = io.read()
    if choice == "title" or choice == "author" or choice == "year" then
        for i, book in ipairs(self) do
            print(i..":"..self[i][choice])
            if i == index then
                books:list_by()
            end
        end
    else if choice == "remove" then
        books:remove_book()
    else if choice == "update" then
        books:upd_book()
    else if choice == "all" then
        for i, book in ipairs(self) do
            print(i..":"..self[i].title..","..self[i].author..","..self[i].year)
            if i == index then
                books:list_by()
            end
        end
    else if choice == "load" then
        books:run()
    else if choice == "save" then
        books:save()
                        else
                            print('Invalid choice. Please enter "title", "author", "year", "remove" or "update"')
                            books:list_by()
                        end
                    end
                end
            end
        end
    end
end

function books:run()
    index = 0
        for line in file:lines() do
            if index == 0 then
                firstLine[index] = line
                index = index + 1
            else
                local split = string.find(line, "\t")
                local split2 = string.find(line, "\t", split + 1)
                local title = string.sub(line, 1, split - 1)
                local author = string.sub(line, split + 1, split2 - 1)
                local year = string.sub(line, split2 + 1)
                if title == nil then
                    print("OHNO!")
                end
                self[index] = Book:new(self[index],title,author,year)
                index = index + 1
            end
        end
        index = index - 1
        books:list_by()
        file:close()
        return index
end

function books:upd_book()
    print("Please type the number of the book you want to edit.")
    local upd_num = tonumber(io.read())
    if upd_num > index or upd_num <=0 then
        print("That book ain't real!!!")
        books:upd_book()
    else
        print(self[upd_num].title.." "..self[upd_num].author.." "..self[upd_num].year)
        print('What part do you want edited "title","author","year"?')
        local upd_choice = io.read()
        if upd_choice == "title" or upd_choice == "author" or upd_choice == "year" then
            print("Please type your edit.")
            local upd_final = io.read()
            self[upd_num][upd_choice] = upd_final
        else
            print("Incorrect command please try again!")
        end
    end
    books:save()
    books:list_by()
end


function books:remove_book()
    print("Write the number of book you want removed.")
    local imput_num = tonumber(io.read())
        if imput_num > index or imput_num <= 0 then
            print("That book ain't real!!!")
            books:remove_book()
        else
            print("Are you sure you want do delete "..self[imput_num].title..", "..self[imput_num].author..", "..self[imput_num].year.." y/n")
            local del_answer = io.read()
                if del_answer == "y" or del_answer == "yes" then
                    table.remove(self,imput_num)
                    index = index - 1
                else if del_answer == "n" or del_answer == "no" then
                    books:list_by()
                else
                    print("Make up your mind before you kill a book.")
                    books:list_by()
                end
            end
        end
    books:save()
    books:list_by()
    return index
end

function books:save()
    local filename = "BMS.save.txt"
    local book_file = io.open(filename,"w")
    for i = 1 , #self do
        if type(i) == "number" then
            book_file:write("{",self[i].title,"}","{",self[i].author,"}","{",self[i].year,"}","\n")
        end
    end
    book_file:close()
end

function books:load()  
    local filename = "BMS.save.txt"
    local book_file = io.open(filename,"r")
    for i = 1,#self do
        if type(i) == "number" then
            table.remove(self,1)
        end
    end
    for line in book_file:lines() do
        title,author,year=line:match("(%b{})(%b{})(%b{})")  
        title=title:sub(2,#title-1)
        author=author:sub(2,#author-1)
        year=year:sub(2,#year-1)
        table.insert(self,Book:new(bt,title,author,year))
        index = index + 1
    end
    book_file:close()
    books:list_by()
end


books:load()

