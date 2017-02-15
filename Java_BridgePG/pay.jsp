<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="bridgeutil.BridgeCryptor"%>
<%@page import="bridgeutil.BridgeFactory"%>
<%@page import="bridgeutil.BridgePgUtil"%>


<section id="inner-headline">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<ul class="breadcrumb">
					<li><a href="index.html">Home</a><i class="icon-angle-right"></i></li>
					<li class="active">Payments</li>
				</ul>
			</div>
		</div>
	</div>
</section>
        <%
			String username="cscdemovle";
			String bridgePrivateKey      = "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tDQpNSUlDZUFJQkFEQU5CZ2txaGtpRzl3MEJBUUVGQUFTQ0FtSXdnZ0plQWdFQUFvR0JBTXJTNFdsaDNsK3pCcmtFDQpNQ3A2MWJ1ZHlVVldrSEowVkNSM1ZmTk8zTEh1ektBazZLUHJDc0NUQjVGWURaT243L3BBdi9yM21lNGtOTEc3DQpUMlp3WWtKT0JNdnY0SVdBcU9qWGRIRGNYZDF1TG93MlNSZ29hVDlqY3JFSHdDSWVqUmI4TUlUbys1bXpIZWJDDQpkQU1wNEtMNVhQelgrUFgvc3JQdTYxZWl5MzNOQWdNQkFBRUNnWUVBaGdVc2ozN3MrdDJJUHE4bXlKc2NLZm9NDQpLZllXUXByZGtxOE1LMWJiKy9Nb1lWV2lKOVpDNTViLzlDbHo1ektjSHdlMEU3aVNqVXA5UzBmVElvUjJWOTZjDQo2Vnl3bWhiYTNXemN0UVliSmpCNzJaZ3NBRFZZRXBSb3VSOVBnSStETENKeVFBb0RnNHR1L0J6a0VaU0ZSUzNFDQpNcFlOYi9UTTZzekRualN0UVowQ1FRRG5BT2dPamd3U1cvTEdvbGdEa1Rkd2FpQ0U3L1BsNHZwYUxFLzlNTU1kDQpvd0NzbU9NN3F6SXZNRUx1dUZ0WUFyMWJ5aEFtdzBQS1pVY1FGWFowVDhqSEFrRUE0TVZibS9yVXRXR242UjR0DQo4a0pzTUxOMXY0blFyaU1HNHBzS2o1V0pvYmpnSWp5UHBxOFhwb2dLYXIra244TGxERHh1TlFIK1hBZWhQNjBYDQpEVVo0eXdKQWJDUG9mcWZRenVkc2g4Q0lJMk5mNktoR0FQV3ozL0taOEl5K0JYRkdaaUZndDJ2N05IdTRTbzcxDQpSbnZYaHlRQk1XOHVrSGJvelY4TUhXTnV5SlJ4RVFKQkFMV1QyYmk5UGo2MUFGOWJhUVN2VWhWWnRJS2lRN21aDQpSRU9sdWpkYU4xQTFPS09QeHdDQnJCcDFCZTFNbWlJUjROVXNzRjhVR0RhaVYwcEllem5YTjFjQ1FRRGpKZVZFDQo2OW1yOXJUeHBMZjdsRVFRbTZQaGl3dW5KaWRXVUp4T2tPY1dTclpqZHRuejJBUkJZdnJnclhkeGdtb0h2YmlsDQp5VzMwOGNITG53Wml6bWVmDQotLS0tLUVORCBQUklWQVRFIEtFWS0tLS0t";
			String bridgePublicKey       = "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0NCk1JR2ZNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0R05BRENCaVFLQmdRQ3FiOVV5T204VkxZS2IyRE1lZVVPaEUvMS8NCmEyNFpwSWIxUHhqanhXNkNpMXFGRkcrVlNJekxqMlhzSHhoUXA4UEw4U3IxNmV2UnhRL2Fmb0F6Uzdia2dBU0wNCmFmRTN4Ym1DQ1JjeFZvVHRLekgzelFJK1FOeDZ3aEFaTXBwWnB1U01Ma3hFK0lFdXY1RHFOSENaZXZ4MkM4Z1kNCkxhVkVBOENPSmFuNUYxaU1nd0lEQVFBQg0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t";
			
			String bridgePayAddress="http://pay.csccloud.in/v1/payment/";
 
			int random_num =  (int)(Math.random() * (100000 - 10000) + 10000 );
            String transactionNo     = "MTXN" + random_num;
            String receiptNo         = "RCPT" + random_num;
            String transactionAmount = "100";
            String productId         = "8695043546";
            String merchantId        = "86950";

            String url = request.getRequestURL().toString();
				System.out.println("step 1 url == "+url);
            String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
				System.out.println("step 2 baseurl == "+baseURL);
            BridgePgUtil bg = new BridgePgUtil();
            bg.createBridgeDefaultParameters();
            bg.addParameter("merchant_id", merchantId);
            bg.addParameter("csc_id", username);
            bg.addParameter("product_id", productId);
            bg.addParameter("txn_amount", transactionAmount);
            bg.addParameter("merchant_txn", transactionNo);
            bg.addParameter("merchant_receipt_no", receiptNo);
            bg.addParameter("return_url", baseURL + "pay_success.jsp");
            bg.addParameter("cancel_url", baseURL + "pay_success.jsp");
            String encText = bg.getEncryptedParameters(bridgePrivateKey, bridgePublicKey);
				System.out.println("step 4 encText == "+encText);
			String urlFraction = bg.getUrlFraction();
				System.out.println("step 3 urlfraction == "+urlFraction);
        %>

	<!-- payment response section  -->
<section id="content">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<h1>Proceed To Pay</h1>
				<h4>Invoice#: <%= receiptNo %></h4>
				<h4>txn ID :  <%= transactionNo %></h4>
				<h3>Amount: <%= transactionAmount %></h3>
				<form method="post" action="<%= bridgePayAddress + urlFraction %>" >
                                    <input type="textfield" name="message" value="<%= merchantId + "|" + encText %>" />
								    <input type="submit" value="Pay" />
				</form>
			</div>
			<div class="col-lg-6">
				<h4>Product Details</h4>
				<p>
					<strong>Information</strong>, write a summary of transaction for VLE to see
				</p>
				
				
		</div>
	
		
		
		<!-- divider -->
		<div class="row">
			<div class="col-lg-12">
				<div class="solidline">
				</div>
			</div>
		</div>

		<!-- end divider -->
		<div class="row">
			<div class="col-lg-12">
				<h4>Wait for Response from CSC Payment Gateway</h4>

			</div>
		</div>
	</div>
</section>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>