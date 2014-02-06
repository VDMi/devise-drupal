module Devise
  module Encryptable
    module Encryptors
      class DrupalHash < Base
	DRUPAL_HASH_COUNT = 15
	DRUPAL_MIN_HASH_COUNT = 7
	DRUPAL_MAX_HASH_COUNT = 30
	DRUPAL_HASH_LENGTH = 55
	ITOA64 = './0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

	HASH = Digest::SHA2.new(512)

	def self.compare(hashed_password, password, stretches, salt, pepper)
		return false if password.nil? or hashed_password.nil?
    
		setting = hashed_password[0..11]
		if setting[0] != '$' or setting[2] != '$'
			# Wrong hash format
			return false
    		end
        
    		count_log2 = ITOA64.index(setting[3])
    
    		if count_log2 < DRUPAL_MIN_HASH_COUNT or count_log2 > DRUPAL_MAX_HASH_COUNT
      			return false
    		end

    		salt = setting[4..4+7]
    
    		if salt.length != 8
      			return false
    		end
    
    		count = 2 ** count_log2
       
    		pass_hash = HASH.digest(salt + password)

    		1.upto(count) do |i|
      			pass_hash = HASH.digest(pass_hash + password)
    		end

    		hash_length = pass_hash.length

    		output = setting + self._password_base64_encode(pass_hash, hash_length)

   		if output.length != 98
      			return false
    		end

    		return output[0..(DRUPAL_HASH_LENGTH-1)] == hashed_password
	end
	
	def self.digest(password, stretches, salt, pepper)
		count_log2 = stretches
		if stretches.nil?
			count_log2 = DRUPAL_HASH_COUNT 	
		end
		return self._password_crypt(password, self._password_generate_salt(count_log2))
	end

	def self._password_crypt(password, hashed_password)
		setting = hashed_password[0..11]
    		if setting[0] != '$' or setting[2] != '$'
      			# Wrong hash format
      			return false
    		end
        
    		count_log2 = ITOA64.index(setting[3])
    
    		if count_log2 < DRUPAL_MIN_HASH_COUNT or count_log2 > DRUPAL_MAX_HASH_COUNT
      			return false
    		end

    		salt = setting[4..4+7]
    
    		if salt.length != 8
      			return false
    		end
    
    		count = 2 ** count_log2
       
    		pass_hash = HASH.digest(salt + password)

    		1.upto(count) do |i|
      			pass_hash = HASH.digest(pass_hash + password)
    		end

    		hash_length = pass_hash.length

    		output = setting + self._password_base64_encode(pass_hash, hash_length)

    		if output.length != 98
      			return false
    		end

    		return output[0..(DRUPAL_HASH_LENGTH-1)]
	end

	def self._password_generate_salt(count_log2)
		output = '$S$'
		output = output + ITOA64[count_log2];
		prng = Random.new(1234 + count_log2)
		output = output + self._password_base64_encode(prng.bytes(6), 6)
	end

	def self._password_base64_encode(to_encode, count)
		output = ''
    		i = 0
    		while true
      			value = (to_encode[i]).ord
          
      			i += 1
          
      			output = output + ITOA64[value & 0x3f]
      			if i < count
        			value |= (to_encode[i].ord) << 8
      			end

      			output = output + ITOA64[(value >> 6) & 0x3f]
  
      			if i >= count
        			break
      			end

      			i += 1
  
      			if i < count
        			value |= (to_encode[i].ord) << 16
      			end
          
      			output = output + ITOA64[(value >> 12) & 0x3f]
  
      			if i >= count
        			break
      			end
      
      			i += 1
      
      			output = output + ITOA64[(value >> 18) & 0x3f]
          
      			if i >= count
        			break
      			end
      
    		end
    		return output
  	end
      end
    end
  end
end
