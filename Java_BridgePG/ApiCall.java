
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;

import javax.net.ssl.HttpsURLConnection;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import bridgeutil.BridgePgUtil;

public class ApiCall {

	public static String resp_status = null ;
	
    

	
	 public static String transaction_enquiry(String merchant_id, String merchant_txn){
	
	
			BridgePgUtil bpg = new BridgePgUtil();
			
			
			bpg.addParameter("merchant_id", merchant_id);
			bpg.addParameter("merchant_txn", merchant_txn);
			
			String encData = bpg.getEncryptedParameters(bridgePrivateKey,bridgePublicKey); 
			
			return CallAPI(merchant_id, encData, "/transaction/enquiry");
		}
		        
		 public static String transaction_status(String merchant_id, String merchant_txn,String csc_txn)
		 {
			BridgePgUtil bg = new BridgePgUtil();
			
			bg.addParameter("merchant_id", merchant_id);
			bg.addParameter("merchant_txn", merchant_txn);
			bg.addParameter("csc_txn", csc_txn);

			String encData = bg.getEncryptedParameters(bridgePrivateKey,bridgePublicKey);
			
			return CallAPI(merchant_id, encData, "/transaction/status");
		 }
		     
		 public static String refund_log(String merchant_id, String merchant_txn, String csc_txn,
										 String merchant_txn_status, String merchant_reference, 
										 String refund_deduction, String refund_mode,
										 String refund_type, String refund_trigger, String refund_reason)
		 {
			BridgePgUtil bg = new BridgePgUtil();
			
			bg.addParameter("merchant_id", merchant_id);
			bg.addParameter("merchant_txn", merchant_txn);
			bg.addParameter("csc_txn", csc_txn);
			bg.addParameter("merchant_txn_status", merchant_txn_status);//Success of Failed at Merchants end
			bg.addParameter("merchant_reference", merchant_reference);//Unique Reference Number
			bg.addParameter("refund_deduction", refund_deduction);//Amount of the Item to get refunded/cancelled
			bg.addParameter("refund_mode", refund_mode);
			bg.addParameter("refund_type", refund_type);
			bg.addParameter("refund_trigger", refund_trigger);
			bg.addParameter("refund_reason", refund_reason);

			String encData = bg.getEncryptedParameters(bridgePrivateKey,bridgePublicKey);
			
			return CallAPI(merchant_id, encData, "/refund/log");
		 }
		 
		 public static String refund_status(String merchant_id, String merchant_txn, String csc_txn, String refund_reference)
		{
			BridgePgUtil bg = new BridgePgUtil();
			
			bg.addParameter("merchant_id", merchant_id);
			bg.addParameter("merchant_txn", merchant_txn);
			bg.addParameter("csc_txn", csc_txn);
			bg.addParameter("refund_reference", refund_reference);

			String encData = bg.getEncryptedParameters(bridgePrivateKey,bridgePublicKey);

			return CallAPI(merchant_id, encData, "/refund/status");
		}

		public static String recon_log(String merchant_id, String merchant_txn, String csc_txn, String cscuser_id, 
				String product_id, String txn_amount, String merchant_date, String merchant_txn_status, 
				String merchant_reciept)
		{

			BridgePgUtil bg = new BridgePgUtil();
			
			bg.addParameter("merchant_id", merchant_id);
			bg.addParameter("merchant_txn", merchant_txn);
			bg.addParameter("csc_txn", csc_txn);
			bg.addParameter("cscuser_id", cscuser_id);
			bg.addParameter("product_id", product_id);
			bg.addParameter("txn_amount", txn_amount);
			bg.addParameter("merchant_date", merchant_date);
			bg.addParameter("merchant_txn_status", merchant_txn_status);
			bg.addParameter("merchant_reciept", merchant_reciept);

			String encData = bg.getEncryptedParameters(bridgePrivateKey,bridgePublicKey);

			return CallAPI(merchant_id, encData, "/recon/log");
		}
		public static String xmlparse(String str){
			Element line = null ;
				
				try{
			
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	        DocumentBuilder db = dbf.newDocumentBuilder();
	        InputSource is = new InputSource();
	        is.setCharacterStream(new StringReader(str));

	        Document doc = db.parse(is);
	        NodeList nodes = doc.getElementsByTagName("xml");
	        
	        for (int i = 0; i < nodes.getLength(); i++) {
	        Element element = (Element) nodes.item(i);
	        NodeList status = element.getElementsByTagName("response_status");
	        line = (Element) status.item(0);
	        resp_status=getCharacterDataFromElement(line);
	        
	        NodeList data = element.getElementsByTagName("response_data");
	        line = (Element) data.item(0);
	        System.out.println("Response Data: " + getCharacterDataFromElement(line));
	        }
				}
				catch(Exception e){
					e.printStackTrace();
				}
				
				return getCharacterDataFromElement(line);
					}
		 public static String getCharacterDataFromElement(Element e) {
			    Node child = e.getFirstChild();
			    if (child instanceof CharacterData) {
			       CharacterData cd = (CharacterData) child;
			       return cd.getData();
			    }
			     
			    return"" ;
			  }
		
		 public static String CallAPI(String merchant_id, String encData, String APIUrl)
		 {
			 
			 URL url=null;
			 HttpURLConnection urlConnection =null;
		
			String xmlData = "<?xml version='1.0' encoding='utf-8'?><xml><merchant_id>"+merchant_id+"</merchant_id><request_data>"+encData+"</request_data></xml>";
			
			//String url = "http://bridgeapi.csccloud.in/v2"+APIUrl;
			
			String output = "";
			 try { 
				   url = new URL("http://bridgeapi.csccloud.in/v2"+APIUrl);
				   urlConnection = (HttpURLConnection)url.openConnection();
				   urlConnection.setRequestMethod("POST");
				   urlConnection.setUseCaches(false);
				   urlConnection.setDoOutput(true);
				   urlConnection.setRequestProperty("Content-Type", "application/xml");
				   urlConnection.setRequestProperty("Accept", "application/xml");
				   urlConnection.connect();
				   
				   OutputStream os = urlConnection.getOutputStream();
			        os.write(xmlData.getBytes());
			        os.flush();
			        os.close();
			        if(urlConnection !=null){
						 BufferedReader rd = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(),Charset.forName("UTF-8")));
					     int a= urlConnection. getResponseCode();
					     System.out.println(a);
					     InputStream s= urlConnection.getErrorStream();
					     System.out.println(s);
					     
					     output = (rd.readLine()).toString();
					      
					      System.out.println("data response"+output);
					     String inputLine = "";
							StringBuilder response = new StringBuilder();

							while ((inputLine = rd.readLine()) != null) 
							{
								response.append(inputLine);
							}
							output=response.toString();
							
							String enc_val=xmlparse(output);
							
						     if(resp_status=="Success"){
							 bridgeutil.BridgeCryptor bg = bridgeutil.BridgeFactory.getBridgeCryptor();
							 bg.setKeys(bridgePrivateKey, bridgePublicKey);
							String dec_vals = bg.decrypt(enc_val);
							 rd.close();
							 urlConnection.disconnect();
					    
				
					     return output;
					     }
					     else{
					    	 
					    		return "Failed: Response Code: "+a;
					     }
					    
					    
			  }	
			 }catch(IOException e){
				    e.printStackTrace();
						 }
			
			return output
		 }
}
