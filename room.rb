class Room

    attr_reader :name, :capacity, :price, :guests, :playlist, :session_clock

    def initialize(name, capacity, price_per_person_per_hour)
        @name = name
        @capacity = capacity
        @price = price_per_person_per_hour
        @guests = []
        @playlist = []
        @session_clock = 0
    end

    def admit_guest(guest)
        if !is_full?
            # Get fee
            charge_guest(guest)
            # Add guest to the array of people in the room
            @guests << guest
        end    
    end

    def charge_guest(guest)
        guest.pay(@price)        
    end

    def clear()
        @guests.clear()
    end

    def add_to_playlist(song)
        @playlist << song
    end

    def get_playlist_reaction(guest)
        song_title = guest.fav_song.title
        if playlist_contains?(guest.fav_song)
            p "#{guest.name}: Yes! Get in! I love #{song_title}"
        else
            p "#{guest.name}: WTF is this shite? I wanted to sing #{song_title}!"
        end
    end

    def is_full?()
        return @guests.count >= @capacity
    end

    def is_time_to_leave?()
        return @session_clock >= 60
    end

    def playlist_contains?(song)
        return @playlist.include?(song)
    end

    def play(song)
        if is_time_to_leave?()
            p "Time's up, guys. Please make your way back to the main bar."
            clear()
        else
            @session_clock += song.duration
        end
    end
    
end
