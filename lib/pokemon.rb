class Pokemon
  attr_accessor :id, :name, :type, :db
  def initialize name:, type:, db:, id:
    @name = name
    @type = type
    @db = db
    @id = id
  end

  def self.save name, type, db
    sql = <<-SQL
      INSERT INTO pokemon (name, type) 
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    @id = db.execute('SELECT last_insert_rowid() FROM pokemon')[0][0]
  end

  def self.find id, db
    sql = "SELECT * FROM pokemon WHERE id = ?"
    new_pokemon = db.execute(sql, id).first
    Pokemon.new(name: new_pokemon[1],type: new_pokemon[2],db: db,id: new_pokemon[0])

  end
end
