# GDSC SOLUTION PROJECT 2024
![스크린샷 2024-02-14 135631](https://github.com/jspark9703/gdsc_solution_project_front/assets/67131959/67cdaa3d-0e14-47c7-adbd-81addbaf1514)

reduce inequality - Web accessibility for visually impaired



# 🐕Shopping guide dog🧑‍🦯

![image](https://github.com/jspark9703/gdsc_solution_project_front/assets/67131959/7ab6b1b0-eef4-4dd1-a0ff-dcbd2076bc4c)


## 🐕index
- preview
- what we use
- what we serve
- API specification
- members

### backend git
https://github.com/jspark9703/gdsc_solution_project_back
The UN’s 17 sustainable development goals that we chose is reducing inequality.


## 🐕preview 


To improve web app accessibility for visually impaired people, we created a shopping guide dog for grocery shopping for the visually impaired.

We observed and analyzed how visually impaired people use smartphones and conducted the project in a direction to identify and improve the problems of other web shopping malls.

As a result, we realized that it is important to deliver key information by identifying the information that users are interested in,

and to textify the information so that it can be understood by the screen readers of iOS’s voiceover and Android’s Talkback.

Users can use voiceover and talkback to shop according to the flow of shopping with only sliding gestures and navigation with a simple UI configuration.

We also designed each screen to use guidance messages to help users recognize the functions, products, and number of reviews, and to simplify the information to reduce the user’s information burden.

We also designed a review summary function so that users can easily check the pros and cons of reviews without reading multiple reviews. 




## 🐕what we use
![스크린샷 2024-02-15 234028](https://github.com/jspark9703/gdsc_solution_project_front/assets/67131959/1e436045-ea81-4d43-abfb-ce1fe937a4d2)


## what we serve

- **Voiceover and Talkback-friendly UI design**
    - Simple UI providing only essential information.
    - Guide messages to navigate the web shopping flow.

- **Review Summary Feature**
    - Summarizes the pros and cons of reviews, making it easier to understand the advantages and disadvantages of a product without reading many reviews.
    - By passing user information as context to the LLM, it's easier to identify elements that the user considers important.

- **Popular Product Food Search**
    - Introduces popular products to offer users new tastes and experiences.

- **Favorite Products Viewing Feature**
    - A feature that helps users quickly and easily find products they have previously favorited.

- **Nutritional Information Provision**
    - Detailed provision of food's nutritional content and amounts.

- **Website Linking Feature**
    - Provides website links so users can directly check and purchase desired products on the website.


## 🐕API specification
https://shopping-guide-dog-final.du.r.appspot.com/redoc

1. Root Endpoint
  Path: /
  
  Method: GET
  
  Summary: Root endpoint, just for test.
  
  Responses:
  200: Successful Response. No specific schema definition provided.

2. Best Filter Endpoint
  Path: /best_filter
  
  Method: GET
  
  Summary: Using Selenium, receive the data of the popular product categories from the online shopping mall Kurly and send it to the client in JSON format.
  
  Responses:
  200: Successful Response.
  RESPONSE SCHEMA: application/json 
  
  <code>
<pre>
    interface DataSchema {
  data: {
    filter_list: FilterItem[];
  };
}

interface FilterItem {
  title: string;
  num: string;
  url: string;
}

  </code>
</pre>

3. Search Product Endpoint
Path: /search_prod

Method: GET

Summary: When receiving keywords from the client through Selenium, fetch the product data from the keyword product search screen. If a link to the popular product categories is provided, access that link to retrieve the product data.

Parameters:
kwds (string, optional): Keywords for search.
is_best_url (string, optional): url in filterItem .

Responses:
200: Successful Response. 
RESPONSE SCHEMA: application/json 

  <code>
<pre>
  interface ProductDataSchema {
  data: {
    prods: ProductItem[];
  };
}

interface ProductItem {
  link: string;
  name: string;
  price: string;
  dimm: string;
  rating_num: string;
}
  </code>
</pre>

422: Validation Error. Returned in case of validation error.
   
4. Product Detail Endpoint
Path: /prod_detail

Method: GET

Summary: Receive the link of a ProductItem and use Selenium to fetch the product's detailed information.

Parameters:
produrl (string, required): Product URL.

Responses:
200: Successful Response. 
RESPONSE SCHEMA: application/json 

  <code>
<pre>
 class ProductDetail(BaseModel):
    prod_img_url:str
    title: str
    sub_title: str
    price: str
    dimm_price:str
    description:str    # prod_option_item: str
    details:List[Item]
    
  </code>
</pre>
    
422: Validation Error. Returned in case of validation error.

5. Product Reviews Endpoint
Path: /prod_reviews

Method: GET

Summary: Receive the link of a ProductItem and use Selenium to deliver the list of reviews.

Parameters:
url (string, required): Reviews URL.

Responses:
200: Successful Response.
RESPONSE SCHEMA: application/json 


422: Validation Error. Returned in case of validation error.

6. Product Review Summary Endpoint
Path: /review_sum

Method: POST

Summary: Receive the list of reviews, user information, and product information, and use LangChain to craft a prompt that appropriately references the three pieces of information. Then, use the OpenAI API to obtain a response and deliver it to the client.

Parameters:
user_info (string, required): User information.
des (string, required): Description.
Request Body: Refer to the ReviewList schema to submit a list of product reviews.

Responses:
200: Successful Response.
RESPONSE SCHEMA: application/json 
  <code>
<pre>
 class ReviewSummary(BaseModel):
    pros: str
    cons: str
    final: str

  </code>
</pre>

422: Validation Error. Returned in case of validation error.



