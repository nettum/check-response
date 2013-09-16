# check-response 

A little shell-script that send X requests against an URL to get response times for each request.   
It also calculates the average response when all requests are done.

## Requirements

curl (apt-get install curl)

## Installation

1. Just make sure that check\_response.sh is executable:  
`chmod u+x check_response.sh`



## Usage

`./check_response.sh <url> <num_requests>`

E.g:  
`./check_response.sh http://www.reddit.com/ 10`
<pre>
Lookup	Connect	PreXfer	StartXfer	Total  
0.034	0.043	0.043	0.174		0.225 
0.016	0.022	0.022	0.037		0.095 
0.017	0.024	0.024	0.043		0.102
0.010	0.016	0.016	0.030		0.093
0.013	0.020	0.020	0.035		0.079 
0.014	0.021	0.021	0.040		0.090 
0.016	0.027	0.027	0.044		0.090 
0.020	0.026	0.026	0.041		0.086 
0.013	0.021	0.021	0.038		0.087 
0.013	0.020	0.020	0.036		0.085     
Average:  
0.016	0.024	0.024	0.051		0.103
</pre>
