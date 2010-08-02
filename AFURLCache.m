/*
 *
 * Copyright 2008 Artifacts - Fine Software Development
 * http://www.artifacts.de
 * Contributed by Nico Schmidt - savoysoftware.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#import "AFURLCache.h"
#import "AFCache+PrivateExtensions.h"

@implementation AFURLCache

-(NSCachedURLResponse*)cachedResponseForRequest:(NSURLRequest*)request
{
    NSURL* url = request.URL;
	AFCacheableItem* item = [[AFCache sharedInstance] cacheableItemFromCacheStore:url];	
	if (item && item.cacheStatus == kCacheStatusFresh) {
		NSURLResponse* response = [[NSURLResponse alloc] initWithURL:item.url 
															MIMEType:item.mimeType 
											   expectedContentLength:[item.data length] textEncodingName:nil];		
		NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:item.data userInfo:nil storagePolicy:NSURLCacheStorageAllowedInMemoryOnly];
		return cachedResponse;
	} else {
		//NSLog(@"Cache miss for file: %@", [[AFCache sharedInstance] filenameForURL: url]);
	}
	
	NSCachedURLResponse *response = [super cachedResponseForRequest:request];
	return response;    
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request
{
//	NSLog(@"request %@ resulted in response: %@", [request description], [cachedResponse description]);
}

@end