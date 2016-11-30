# Gilded Rose Tech Test   

##Setup

* Navigate to the target folder you want to store these files
* In the comman line, run:

```
git clone https://github.com/wirsindpapst/GildedRose-Refactoring-Kata.git
cd GildedRose-Refactoring-Kata/ruby
gem install rspec
```
## Testing approach

* Tested using the RSpec framework, to run tests:

```
rspec  
```
## Approach to the problem

* Mapped the routing logic
* Initially focused on 'vanilla items' that do no have special properties
  1) Is quality zero?
  2) Is it still in sell in date?
* Looked into more sophisticated rules engines ... but dieced that within the time constraints better to take an incremental approach
* Once this was done, I then focused on determining how to deal with 'special' items .... this is when my brain started to fry

## Where I'm at

### I was comfortable at first .... now it's a bit of a mess

* Logic for applying quality and Sellin changes to vanilla items
* Above logic tested
* Logic for routing of 'vanilla' items through this lgoic in place
* Above logic tested (excluding edge cases)
* Logic for applying quality changes to 'special' items
* Above logic tested
* Some of the logic for routing 'special' items through logic

## What's left to do

* Testing of routing logic for 'special' items
* Logic to apply increased quality SellIn reduction to
* Testing of edge cases
