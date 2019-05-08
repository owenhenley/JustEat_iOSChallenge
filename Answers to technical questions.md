# Owen Henley 
#### Associate iOS Engineer
###### London

## Technical questions

###### 1. How long did you spend on the coding test? What would you add to your solution if you had more time? If you didn't spend much time on the coding test then use this as an opportunity to explain what you would add.

I spent around 10 hours over a few evenings on this task.

- Abstract the delegates' into their own class's.
- Write more tests with mocks and stubs.
	- Particularly for the NetworkController and the CoreLocation.
		-	(My current team uses 'Sourcery' to auto generate what we need, so learning how to write manual mocks an stubs would be interesting).
- Fuzzy search/auto refresh as you type would be cool.
- Add some error codes for the network.
- Validate Postcode with Regex.


###### 2. What was the most useful feature that was added to the latest version of your chosen language? Please include a snippet of code that shows how you've used it.

I really like the new raw strings:

```swift
let lipsumRawString = #"Lorem ipsum dolor sit amet, "consectetur" adipiscing "elit". Duis varius, ante non \#(bibendum) elementum"#
// prints "Lorem ipsum dolor sit amet, "consectetur" adipiscing "elit". Duis varius, ante non bibendum elementum"
```

I've seen many people celebrate about the standard `Result` type, but I havent looked into it much.

###### 3. How would you track down a performance issue in production? Have you ever had to do this?
I have never had to do this. To the best of my knowledge, this looks like you would use Instruments for.


###### 4. How would you improve the Just Eat APIs that you just used?
There doesnt seem to be any way to paginate the results? Maybe this could be implimented so you use as little of the users network data as possible, thus speeding up app responsiveness.

Also, personal preference, the keys are all upper camel case, so its makes our models/Dtos's look pretty ugly.

###### 5. Please describe yourself using JSON.

```json
[
	{
		"name": "Owen Heney",
		"website": "owenhenley.io",
		"overview: "Just an overall good guy."
		"dogLover": true,
		"hobbies": [
			"Hiking",
			"Mountain Biking",
			"Photography",
			"Film Making"
		]
	}
]
```