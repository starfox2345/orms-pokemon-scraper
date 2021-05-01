class Pokemon
    attr_accessor :id, :name, :type, :db
    # attr_reader :db

    def initialize(options={})
        options.each do |key, value|
            self.send("#{key}=", value) if respond_to?("#{key}=")
        end
    end
    # def initialize(id, name, type, db)
    #     @id = id
    #     @name = name
    #     @type = type
    #     @db = db
    # end
    def save
        sql = <<-SQL
            INSERT INTO pokemon(name, type) VALUES (?, ?)
        SQL
        
        DB[:conn].execute(sql, self.name, self.type)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end
end
