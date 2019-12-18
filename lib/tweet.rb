class Tweet
  attr_accessor :message, :username
  # @@all = []

  attr_reader :id

  def self.all
    # @@all

    sql = 'SELECT * FROM tweets'
    results = DB[:conn].execute(sql)

    results.map{|hash| Tweet.new(hash)}
  end

  def initialize(props={})
    @message = props['message']
    @username = props['username']
    @id = props['id']
    #@@all << self
  end

  def save
    if self.id # if objs hv ID attr need to update info
      sql = 'UPDATE tweets SET message=?, username=? WHERE id=?'

      DB[:conn].execute(sql, self.message, self.username, self.id)      
    else
      # white listing
      sql = 'INSERT INTO tweets (message, username) VALUES (?,?)'
      
      DB[:conn].execute(sql, self.message, self.username)
    end

  end

  def self.delete(tweet_obj)
    sql = 'DELETE FROM tweets WHERE id=?'

    DB[:conn].execute(sql, tweet_obj.id)
  end

  def delete
    sql = 'DELETE FROM tweets WHERE id=?'

    DB[:conn].execute(sql, self.id)
  end

  def self.find_by_id(identity)
    sql = 'SELECT * FROM tweets WHERE id=?'

    row_arr = DB[:conn].execute(sql, identity)

    # always return an obj
    Tweet.new(row_arr.first)
  end
end
