Вызов методов public private и protected на экземплярах класса

class Parent

	def initialize(name, age)
		 @name = name
		 @age = age
	end

	def public_method_parent_class
		'string_public_method_parent_class'
	end

	protected
	def protected_method_parent_class
		'string_protected_method_parent_class'
	end

	private
	def private_method_parent_class
		'string_private_method_parent_class'
	end
end

class Children < Parent
	def initialize(name, age)
		 @name = name
		 @age = age
	end
end

igor = Parent.new('Ivan',35)
sergey = Children.new('Sergey',15)



puts igor.public_method_parent_class   #return content public_method_parent_class
puts sergey.public_method_parent_class #return content public_method_parent_class

puts igor.protected_method_parent_class   #return error
puts sergey.protected_method_parent_class #return error

puts igor.private_method_parent_class   #return error
puts sergey.private_method_parent_class #return error



Вызов публичных методов на экземплярах класса, в которых используются приватный и защищенный методы с self и без

class Parent

	def public_method_parent_class_with_protected_method_without_self
		"string_public_method_parent_class #{protected_method_parent_class}"
	end

	def public_method_parent_class_with_protected_method_with_self
		"string_public_method_parent_class #{self.protected_method_parent_class}"
	end

	def public_method_parent_class_with_private_method_without_self
		"string_public_method_parent_class #{private_method_parent_class}"
	end

	def public_method_parent_class_with_private_method_with_self
		"string_public_method_parent_class #{self.private_method_parent_class}"
	end

	protected
	def protected_method_parent_class
		'string_protected_method_parent_class'
	end

	private
	def private_method_parent_class
		'string_private_method_parent_class'
	end
end

class Children < Parent
end

igor = Parent.new
sergey = Children.new

puts igor.public_method_parent_class_with_protected_method_without_self # no errors
puts igor.public_method_parent_class_with_protected_method_with_self    # no errors
puts igor.public_method_parent_class_with_private_method_without_self   # no errors
puts igor.public_method_parent_class_with_private_method_with_self      # error !!!

Аналогичная ситуация будет, если эти же методы будут вызваны на объектах наследованного класса.

puts sergey.public_method_parent_class_with_protected_method_without_self # no errors
puts sergey.public_method_parent_class_with_protected_method_with_self    # no errors
puts sergey.public_method_parent_class_with_private_method_without_self   # no errors
puts sergey.public_method_parent_class_with_private_method_with_self      # error !!!


Теперь, для более полного понимания, необходимо разобраться зачем может быть необходимо использовать защищенные методы на объектах своего класса (через self)
Случай 1: Мы хотим сравнить является ли объект родительского или наследуемого класса объектом родительского класса.

class User

  def equal_class_user_with_protected_method(other_user)
    other_user.class == self.protected_method_definition_class
  end

  protected

  def protected_method_definition_class
    self.class
  end
end

class Kiborg < User
end

bob = User.new
lex = User.new
john = Kiborg.new

puts bob.equal_class_user_with_protected_method(john).class # return false
puts bob.equal_class_user_with_protected_method(lex).class  # return true


Здесь возникает вопрос: зачем нам использовать защищенные методы внутри публичных методов, если мы можем там использовать публичные методы?
Ответ: для выполнения определенных задач, в которых необходимо использовать объект указанного класса.