import csv

def readerList(fieldnames, path, hasColumnNames = True):
	contactsReader = csv.DictReader(open(path, 'rU'), fieldnames);
	return hasColumnNames and list(contactsReader)[1:] or list(contactsReader)
	
	
def main():
	kz_zipcodes = [ZipCode(i) for i in readerList(['zipcode','representative','phone','email'], '/Users/temp/Documents/Gen-Probe/Contact Us Revision/website_ussalesrep_zipcodes_gpwlifecodes_deduped.csv')]
	
	d = {}
	for zc in kz_zipcodes:	
		if zc.zipcode in d.keys():
			print str(zc)
		else:
			d[zc.zipcode] = str(zc)
			
	
def main2():
	kz_zipcodes = readerList(['zipcode','representative','phone','email'], '/Users/temp/Documents/Gen-Probe/Contact Us Revision/website_ussalesrep_zipcodes_gpwlifecodes_deduped.csv')
	
	li = [row['zipcode'] for row in kz_zipcodes]
	if len(li) == len(set(li)):
		print 'No Dupes'
	else:
		print 'Dupes'
	
	return 
	
	d = {}
	for row in kz_zipcodes:	
		zipcode = row['zipcode'];
		if zipcode in d.keys():
			print str(zipcode)
		else:
			d[zipcode] = row	
	
		
class ZipCode(object):
	def __init__(self, row):
		self.data = row
		
	def __getattribute__(self, key):
		data = object.__getattribute__(self, 'data');
		if key in data.keys():
			return data[key]
		else:
			return None
			
	def __str__(self):
		return self.zipcode
		
		
if __name__ == '__main__':
	main2();