/*

Adobe Systems Incorporated(r) Source Code License Agreement

Copyright(c) 2005 Adobe Systems Incorporated. All rights reserved.

	

Please read this Source Code License Agreement carefully before using

the source code.

	

Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive,

no-charge, royalty-free, irrevocable copyright license, to reproduce,

prepare derivative works of, publicly display, publicly perform, and

distribute this source code and such derivative works in source or

object code form without any attribution requirements.

	

The name "Adobe Systems Incorporated" must not be used to endorse or promote products

derived from the source code without prior written permission.

	

You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and

against any loss, damage, claims or lawsuits, including attorney's

fees that arise or result from your use or distribution of the source

code.

	

THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT

ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,

BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS

FOR A PARTICULAR PURPOSE ARE DISCLAIMED. ALSO, THERE IS NO WARRANTY OF

NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT. IN NO EVENT SHALL MACROMEDIA

OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,

EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,

PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;

OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,

WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR

OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF

ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/



package com.adobe.webapis.flickr.methodgroups {

	

	import com.adobe.webapis.flickr.events.FlickrResultEvent;

	import com.adobe.webapis.flickr.*;

	import com.adobe.crypto.MD5;

	import flash.events.Event;

	import flash.net.URLLoader;

	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import com.adobe.utils.StringUtil;
	import flash.net.URLRequestMethod;



	/**

	 * Broadcast as a result of the checkTickets method being called

	 *

	 * The event contains the following properties

	 *	success	- Boolean indicating if the call was successful or not

	 *	data - When success is true, contains an "uploadTickets" array of UploadTicket instances

	 *		   When success is false, contains an "error" FlickrError instance

	 *

	 * @see #checkTickets

	 * @see com.adobe.service.flickr.FlickrError

	 * @langversion ActionScript 3.0

	 * @playerversion Flash 8.5

	 * @tiptext

	 */

	[Event(name="photosUploadCheckTickets", 

		 type="com.adobe.webapis.flickr.events.FlickrResultEvent")]

	

	/**

	 * Contains the methods for the Upload method group in the Flickr API.

	 * 

	 * Even though the events are listed here, they're really broadcast

	 * from the FlickrService instance itself to make using the service

	 * easier.

	 */

	public class Upload {



		/** 

		 * A reference to the FlickrService that contains the api key

		 * and logic for processing API calls/responses

		 */

		private var _service:FlickrService;

		

		/**

		 * The destination for photo uploads

		 */

		private static const UPLOAD_DEST:String = "http://www.flickr.com/services/upload/";

	

		/**

		 * Construct a new Upload "method group" class

		 *

		 * @param service The FlickrService this method group

		 *		is associated with.

		 * @langversion ActionScript 3.0

		 * @playerversion Flash 8.5

		 * @tiptext

		 */

		public function Upload( service:FlickrService ) {

			_service = service;

		}

	

		/**

		 * Checks the status of one or more asynchronous photo upload tickets.

		 *

		 * @param tickets An array of ticket ids (number or string)

		 * @see http://www.flickr.com/services/api/flickr.photos.upload.checkTickets.html

		 * @langversion ActionScript 3.0

		 * @playerversion Flash 8.5

		 * @tiptext

		 */

		public function checkTickets( tickets:Array ):void {

			// Let the Helper do the work to invoke the method			

			MethodGroupHelper.invokeMethod( _service, checkTickets_result, 

								   "flickr.photos.upload.checkTickets", 

								   false,

								   new NameValuePair( "tickets", tickets.join(",") ) );

		}

		

		/**

		 * Capture the result of the checkTickets call, and dispatch

		 * the event to anyone listening.

		 *

		 * @param event The complete event generated by the URLLoader

		 * 			that was used to communicate with the Flickr API

		 *			from the invokeMethod method in MethodGroupHelper

		 */

		private function checkTickets_result( event:Event ):void {

			// Create a PHOTOS_UPLOAD_CHECK_TICKETS event

			var result:FlickrResultEvent = new FlickrResultEvent( FlickrResultEvent.PHOTOS_UPLOAD_CHECK_TICKETS );



			// Have the Helper handle parsing the result from the server - get the data

			// from the URLLoader which correspondes to the result from the API call

			MethodGroupHelper.processAndDispatch( _service, 

												  URLLoader( event.target ).data, 

												  result,

												  "uploadTickets",

												  MethodGroupHelper.parseUploadTicketList );

		}

		

		/**

		 * Uploads a photo to the Flickr service

		 *

		 * @param fileReference The fileReference that the user "browsed" to

		 *		so that upload works correctly.

		 * @param title (Optional) The title of the photo.

		 * @param description (Optional) A description of the photo. May contain

		 *		some limited HTML.

		 * @param tags (Optional) A space-seperated list of tags to apply to

		 *		the photo.

		 * @param is_public (Optional) True if the photo is public, false otherwise

		 * @param is_friend (Optional) True if the photo should be marked for friends,

		 *		false otherwise

		 * @param is_family (Optional) True if the photo should be marked for family

		 *		access only, false otherwise

		 * @langversion ActionScript 3.0

		 * @playerversion Flash 8.5

		 * @tiptext

		 */

	

		//Upload isn't supported yet - need some player modifications first.



	public function upload( fileReference:FileReference, 

								title:String = "",

								description:String = "",

								tags:String = "",

								is_public:Boolean = false,

								is_friend:Boolean = false,

								is_family:Boolean = false ) : void {

			// The upload method requires signing, so go through

			// the signature process



			// [OvD] Flash sends both the 'Filename' and the 'Upload' values

			// in the body of the POST request, so these are needed for the signature

			// as well, otherwise Flickr returns a error code 96 'invalid signature'

			var sig:String = StringUtil.trim( _service.secret );

			sig += "Filename" + fileReference.name;

			sig += "UploadSubmit Query"; //				

			sig += "api_key" + StringUtil.trim( _service.api_key );

			sig += "auth_token" + StringUtil.trim( _service.token );		

			

			// [OvD] optional values, the order is irrelevant

			if ( description != "" ) sig += "description" + description;

			if ( is_family ) sig += "is_family" + ( is_family ? 1 : 0 );

			if ( is_friend ) sig += "is_friend" + ( is_friend ? 1 : 0 );

			if ( is_public ) sig += "is_public" + ( is_public ? 1 : 0 );

			if ( tags != "" ) sig += "tags" + tags;

			if ( title != "" ) sig += "title" + title;



			var vars:URLVariables = new URLVariables();

			vars.auth_token = StringUtil.trim( _service.token );

			vars.api_sig = MD5.hash( sig );

			vars.api_key = StringUtil.trim(  _service.api_key );

			

			// [OvD] optional values, same order as the signature

			if ( description != "" ) vars.description = description;

			if ( is_family ) vars.is_family = ( is_family ? 1 : 0 );

			if ( is_friend ) vars.is_friend = ( is_friend ? 1 : 0 );

			if ( is_public ) vars.is_public = ( is_public ? 1 : 0 );

			if ( tags != "" ) vars.tags = tags;

			if ( title != "" ) vars.title = title;



			var request:URLRequest = new URLRequest( UPLOAD_DEST );

			request.data = vars;

			request.method = URLRequestMethod.POST;

			

			// [OvD] Flickr expects the filename parameter to be named 'photo'

			fileReference.upload( request, "photo" );

		}

		

	}	

	

}