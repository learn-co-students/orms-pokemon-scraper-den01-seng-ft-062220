class Pokemon

    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize id:, name:, type:, db:
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save name, type, db
        sql = <<-SQL
            insert into pokemon (name, type) values (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find id, db
        sql = <<-SQL
            select * from pokemon where id = ? limit 1
        SQL
        info = db.execute(sql, id).flatten
        Pokemon.new(id: info[0], name: info[1], type: info[2], db: db)
    end


end
