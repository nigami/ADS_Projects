import csv
def to_kaggle(location_input_file, header="", location_output_file="kaggle.submission.csv"):
  print "\nReading:",location_input_file,"\nWriting:",location_output_file
  with open(location_input_file) as infile, open(location_output_file, "wb") as outfile:
    if len(header) > 0:
	  outfile.write( header + "\n" )
    reader = csv.reader(infile, delimiter=" ")
    for row in reader:
      outfile.write( row[1] + "," + str(int(row[0][0])-1) + "\n" )

to_kaggle("rotten.preds.txt", "PhraseId,Sentiment")