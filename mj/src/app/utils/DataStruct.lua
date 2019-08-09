--基本数据结构

--[[ List ]]
List = { data = nil,front = nil, back = nil,count = 0}

function List:new(o)
   o = o or {};  
   
   o.data =  {_next = nil,pre = nil};
   o.front = o.data;
   o.back =  o.data;  
   o.count = o.count or 0;
   
   o.data._next = o.back;
   o.data.pre = o.front;

   setmetatable(o, self);
	 self.__index = self;  
   return o;
end

function List:push_back(v)
   self.count = self.count + 1;
   local newitem = {value = v,_next = nil,pre = nil};
   if self.front == self.back then
       self.front = newitem;
       self.front._next = self.back;
       self.front.pre = self.back;
       self.back.pre = self.front;
       self.back._next = self.front;
       return;
   end
   
   local last = self.back.pre;
   last._next = newitem;
   newitem.pre = last;
   newitem._next = self.back;
   self.back.pre = newitem;
end

function List:push_front(v)
  self.count = self.count + 1;
   local newitem = {value = v,_next = nil,pre = nil};
   if self.front == self.back then
       self.front = newitem;
       self.front._next = self.back;
       self.front.pre = self.back;
       self.back.pre = self.front;
       self.back._next = self.front;
       return;
   end
   local front = self.front;
   newitem.pre = front.pre;
   newitem._next = front;
   front.pre._next = newitem;
   front.pre = newitem;
   self.front = newitem;
end

function List:last()
   return self.back.pre.value;
end

function List:pop_front()
    local ret = self.front.value
    self:remove(ret)
    return ret
end

function List:remove(v)
    local from = self.front;
    while(from ~= self.back) do
       if from.value == v then
          local preitem = from.pre;
          local nextitem = from._next;
          preitem._next = nextitem;
          nextitem.pre = preitem;
          self.count = self.count - 1;
          if from == self.front then
             self.front =  nextitem;
          end
          break;
       end
       from = from._next;
    end
end

--[[ Array ]]
Array = {}
function Array:new(o)
   o = o or {};  
   setmetatable(o, self)
   self.__index = self
   return o;
end

function Array:add(o)
   table.insert(self,o)
end

function Array:insert(pos,o)
   if pos == -1 then
      table.insert(self,o);
      return;
   end
   table.insert(self,pos,o)
end

function Array:indexOf(o)
    for i,v in ipairs(self) do
       if v == o then
          return i;
       end
    end
    return 0;
end

function Array:remove(pos)
   table.remove(self,pos);
end

function Array:removeElement( value )
    for i, v in ipairs(self) do
      if v == value then
        self:remove(i)
        break
      end
    end
end

function Array:clear()
  for i, v in ipairs(self) do
    self[i] = nil
  end
end

function Array:size()
   table.getn(self);  
end

--[[ Queue ]]
Queue = class("Queue")

function Queue:ctor(capacity)
    self.capacity = capacity
    self.queue = {}
    self.size_ = 0
    self.head = -1
    self.rear = -1
end

function Queue:enQueue(element)
    if self.size_ == 0 then
        self.head = 0
        self.rear = 1
        self.size_ = 1
        self.queue[self.rear] = element
    else
        local temp = (self.rear + 1) % self.capacity
        if temp == self.head then
            printError("Error: capacity is full.")
            return 
        else
            self.rear = temp
        end

        self.queue[self.rear] = element
        self.size_ = self.size_ + 1
    end

end

function Queue:deQueue()
    if self:isEmpty() then
        printError("Error: The Queue is empty.")
        return
    end
    self.size_ = self.size_ - 1
    self.head = (self.head + 1) % self.capacity
    local value = self.queue[self.head]
    return value
end

function Queue:clear()
    self.queue = nil
    self.queue = {}
    self.size_ = 0
    self.head = -1
    self.rear = -1
end

function Queue:isEmpty()
    if self:size() == 0 then
        return true
    end
    return false
end

function Queue:size()
    return self.size_
end

function Queue:printElement()
    local h = self.head
    local r = self.rear
    local str = nil
    local first_flag = true
    while h ~= r do
        if first_flag == true then
            str = "{"..self.queue[h]
            h = (h + 1) % self.capacity
            first_flag = false
        else
            str = str..","..self.queue[h]
            h = (h + 1) % self.capacity
        end
    end
    str = str..","..self.queue[r].."}"
    print(str)
end

--[[ Stack ]]
local Stack = class("Stack")

function Stack:ctor()
    self.stack_table = {}
end

function Stack:push(element)
    local size = self:size()
    self.stack_table[size + 1] = element
end

function Stack:pop()
    local size = self:size()
    if self:isEmpty() then
        printError("Error: Stack is empty!")
        return
    end
    return table.remove(self.stack_table,size)
end

function Stack:top()
    local size = self:size()
    if self:isEmpty() then
        printError("Error: Stack is empty!")
        return
    end
    return self.stack_table[size]
end

function Stack:isEmpty()
    local size = self:size()
    if size == 0 then
        return true
    end
    return false
end

function Stack:size()
    return table.nums(self.stack_table) or 0
end

function Stack:clear()
    -- body
    self.stack_table = nil
    self.stack_table = {}
end

function Stack:printElement()
    local size = self:size()

    if self:isEmpty() then
        printError("Error: Stack is empty!")
        return
    end

    local str = "{"..self.stack_table[size]
    size = size - 1
    while size > 0 do
        str = str..", "..self.stack_table[size]
        size = size - 1
    end
    str = str.."}"
    print(str)
end

