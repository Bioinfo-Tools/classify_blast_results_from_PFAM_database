


require(dcGOR)

args <- commandArgs(trailingOnly = TRUE)

print(args)

blast_result <- read.table(args[1], header=FALSE, sep="\t")

data(Pfam)
data(Pfam2GOMF)

#head(Pfam2GOMF@domainData@data)
#head(Pfam@data)

#myGO <- names(which(annoData(Pfam2GOMF)["PF07528",]==1))
#myGOMF <- as.character(subset(Pfam2GOMF@termData@data, ID==myGO)$Name)
#myDescription <- as.character(subset(Pfam@data, id=="PF00002")$description)

new_blast_result <- subset(blast_result, V3>=args[2])
new_blast_result <- subset(new_blast_result, V11<=args[3])


new_blast_result$Description <- rep("Unknown", nrow(new_blast_result))
new_blast_result$Function <- rep("Unknown", nrow(new_blast_result))
new_blast_result$GO <- rep("Unknown", nrow(new_blast_result))

for(i in 1:nrow(new_blast_result)){
    
    myPFAM <- as.character(new_blast_result[i,2])
    print(myPFAM)
    myGO <- NULL
    myGOMF <-NULL
    myDescription <- NULL
    
    if(myPFAM %in% rownames(annoData(Pfam2GOMF))){
        
        myGO <- names(which(annoData(Pfam2GOMF)[myPFAM,]==1))
        myGOMF <- as.character(subset(Pfam2GOMF@termData@data, ID==myGO[1])$Name)
        newGO <- myGO[1]
        
        if(length(myGO)>1){    
            for(j in 2:length(myGO)){
                myGOMF <- paste(myGOMF, as.character(subset(Pfam2GOMF@termData@data, ID==myGO[j])$Name), sep=",")
                
            
            }          
            newGO <- paste(newGO, myGO[j], sep=",")    
                        
        }

        new_blast_result$Function[i] <- myGOMF
        new_blast_result$GO[i] <- newGO
    }
        
    if(myPFAM %in% Pfam@data$id){
        
        myDescription <- as.character(subset(Pfam@data, id==myPFAM)$description)
        new_blast_result$Description[i] <- myDescription
        print(length(myDescription))

        

    }


    
}


new_blast_result$count <- rep(1,nrow(new_blast_result))
summaryfunction <- aggregate(count ~ Function, new_blast_result, sum)
summarydescription <- aggregate(count ~ Description, new_blast_result, sum)


filename <- paste(args[1], "summary_PFAM_Description.txt", sep="_")

write.table(file=filename, summarydescription, quote=F, row.names=FALSE, col.names=TRUE, sep="\t")


filename <- paste(args[1], "summary_GO_Function.txt", sep="_")

write.table(file=filename, summaryfunction, quote=F, row.names=FALSE, col.names=TRUE, sep="\t")
