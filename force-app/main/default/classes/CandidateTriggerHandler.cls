public class CandidateTriggerHandler 
{

    
    
             
              // Req - 3
                    public static void createSkillandCandidateSkillRecord (List<Candidate__c> candidateList)
            {
                        
                    Set<String> allSkillNames = new Set<String>();
                    Map<Id, List<String>> candidateToSkillNames = new Map<Id, List<String>>();
                                           
            
                    // 1️⃣ Parse all skill names from candidates
                    for (Candidate__c cand : candidateList) {
                        if (String.isNotBlank(cand.Skill_Set__c)) {
                            List<String> skills = new List<String>();
                            for (String s : cand.Skill_Set__c.split(',')) {
                                String clean = s.trim();
                                if (clean != '') {
                                    allSkillNames.add(clean.toLowerCase());
                                    skills.add(clean.toLowerCase());
                                }
                            }
                            candidateToSkillNames.put(cand.Id, skills);
                        }
                    }
                    
                    if (allSkillNames.isEmpty()) return;
                    
                    // 2️⃣ Query existing Skill records
                    Map<String, Skill__c> existingSkills = new Map<String, Skill__c>();
                    for (Skill__c sk : [SELECT Id, Name FROM Skill__c WHERE Name IN :allSkillNames]) {
                        existingSkills.put(sk.Name.toLowerCase(), sk);
                    }
                    
                    // 3️⃣ Find missing skills
                    List<Skill__c> newSkills = new List<Skill__c>();
                    for (String skillName : allSkillNames) {
                        if (!existingSkills.containsKey(skillName)) {
                            newSkills.add(new Skill__c(Name = skillName));
                        }
                    }
                    
                    // 4️⃣ Insert missing skills
                    if (!newSkills.isEmpty()) {
                        insert newSkills;
                        for (Skill__c s : newSkills) {
                            existingSkills.put(s.Name.toLowerCase(), s);
                        }
                    }
                    
                    // 5️⃣ Prepare CandidateSkill records
                    List<CandidateSkill__c> candidateSkillRecords = new List<CandidateSkill__c>();
                    for (Id candId : candidateToSkillNames.keySet()) {
                        for (String skillName : candidateToSkillNames.get(candId)) {
                            Skill__c skill = existingSkills.get(skillName);
                            if (skill != null) {
                                candidateSkillRecords.add(new CandidateSkill__c(
                                    Candidate__c = candId,
                                    Skill__c = skill.Id
                                ));
                            }
                        }
                    }
                    
                    // 6️⃣ Insert junction records
                    if (!candidateSkillRecords.isEmpty()) {
                        insert candidateSkillRecords;
                    }
            
            }
                
            
        
            
            
        
        
        
        
        
        
        
        
            
              // Req - 2
                public static void updateUinNumberFieldonCandidate (List<Candidate__c> candidateList)
            {
                        
                     
                               
                
                        for (Candidate__c can : candidateList)
                        {
        
                            
                                        if (can.Year_of_Passing__c != null &&
                                            String.isNotBlank(can.Branch__c) &&
                                            String.isNotBlank(can.City_of_Birth__c) &&
                                            can.Year_of_Birth__c != null) 
                                        
                                        {
                            
                                                
                                            // ✅ Year of Passing → last two digits
                                            String yearPart = String.valueOf(can.Year_of_Passing__c).right(2);
                                                
                                            // ✅ Branch Code Mapping (custom abbreviations)                                        
                                            String branchPart = getBranchCode(can.Branch__c);
                                                
                                            
                                                
                                            // ✅ City → first two letters (uppercased)    
                                            String cityPart = can.City_of_Birth__c.length() >= 2 ? can.City_of_Birth__c.substring(0,2).toUpperCase() : can.City_of_Birth__c.toUpperCase();
                                                
                                            // ✅ Year of Birth
                                            String yobPart = String.valueOf(can.Year_of_Birth__c);
                            
                                            
                                            
                                            // ✅ Final UIN
                                            can.UIN_Number__c = yearPart + '-' + branchPart + cityPart + '-' + yobPart;
                                        }
                            
                            
                            
                        }
                
                
                        
                
            }
            
            
            
            
            
            // Helper method for Branch abbreviation mapping
            public static String getBranchCode(String branchName) 
            {
                branchName = branchName.trim().toLowerCase();
                
                if (branchName.contains('computer') && branchName.contains('science')) return 'CS';
                if (branchName.contains('information') && branchName.contains('technology')) return 'IT';
                if (branchName.contains('mechanical')) return 'ME';
                if (branchName.contains('electrical')) return 'EE';
                if (branchName.contains('civil')) return 'CE';
                if (branchName.contains('electronics') && branchName.contains('communication')) return 'EC';
                if (branchName.contains('chemical')) return 'CH';
                if (branchName.contains('biotechnology')) return 'BT';
                if (branchName.contains('aeronautical')) return 'AE';
                
                // Default: take first two uppercase letters
                return branchName.length() >= 2 
                    ? branchName.substring(0, 2).toUpperCase() 
                    : branchName.toUpperCase();
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
             //Record Triggered Flow or Trigger - 4
            public static void setValidationonEmailField (List<Candidate__c> candidateList)
            {
                        
                        Map<String,Candidate__c> canEmailMap = new Map<String,Candidate__c>();
                               
                
                        for (Candidate__c can : [Select Email__c from Candidate__c])
                        {
                            
                            
                            if(can.Email__c != null)
                            {
                                canEmailMap.put(can.Email__c,can);
                            }
                            
                        }  
                
                
                
                
                
                        for (Candidate__c can : candidateList)
                        {
                            
                            if(canEmailMap.get(can.Email__c) != null)
                            {
         
                                can.Duplicate_Found__c = true;
                                
                                //can.addError('Email Already Exists!...');
                            }
                            
                            
                            
                        }        
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //Record Triggered Flow or Trigger - 1
            
            public static void sendEmailtoCandidate (List<Candidate__c> candidateList, Map<Id,Candidate__c> oldMap)
            {
                
                
                List<Messaging.Email> emailList = new List<Messaging.Email>();
                
                
                for (Candidate__c can : candidateList)
                {
                    
                    
                    if((oldMap == null && can.Email__c != null)
                       || (oldMap != null && can.Email__c != null && oldMap.get(can.Id).Email__c != can.Email__c)
                      )
                    {
                        
                        
                        Messaging.SingleEmailMessage emailMsg= new Messaging.SingleEmailMessage();
                        
                        String[] toAddress= new String[] {can.Email__c};
                            emailMsg.setToAddresses (toAddress);
                        
                        String emailSubject = 'Welcome '+can.First_Name__c;
                        emailMsg.setSubject (emailSubject);
                        
                        String disName='Sanjay Gupta';
                        emailMsg.setSenderDisplayName (disName);
                        
                        
                        String content = 'Hi '+can.First_Name__c+ ', <br/><br/>'+
                            'Welcome to SalesForce EcoSystem! <br/><br/>'+
                            'Happy learning! <br/><br/>'+
                            'Thank you! <br/><br/>';
                        emailMsg.setHtmlBody (content);
                        
                        
                        emailList.add(emailMsg);
                        
                    }
                    
                }
                
                
                Messaging.sendEmail (emailList);
                
                
            }
    
    
}