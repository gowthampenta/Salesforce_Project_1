public with sharing class TeamMemberController {

    @AuraEnabled
    public static Id createTeamMember(
        Id userId,
        Id initiativeId,
        String discipline,
        Decimal allocation
    ) {

        Team_Member__c tm = new Team_Member__c();

        tm.User__c = userId;
        tm.Initiative__c = initiativeId;
        tm.Discipline__c = discipline;
        tm.Resource_Time_Allocation__c = allocation;
        tm.Active__c = true;

        insert tm;

        return tm.Id;
    }


    @AuraEnabled
    public static List<Map<String,Object>> getTeamMembers(
        Id initiativeId
    ){

        List<Map<String,Object>> results =
            new List<Map<String,Object>>();

        for(
            Team_Member__c tm :
            [
                SELECT Id,
                       Name,
                       User__c,
                       User__r.Name,
                       Discipline__c,
                       Resource_Time_Allocation__c,
                       Initiative__c,
                       Initiative__r.Name

                FROM Team_Member__c

                WHERE Initiative__c = :initiativeId

                ORDER BY Name
            ]
        ){

            Map<String,Object> row =
                new Map<String,Object>();

            row.put('Id', tm.Id);

            row.put('Name', tm.Name);

            row.put(
                'userName',
                tm.User__r != null
                ? tm.User__r.Name
                : ''
            );

            row.put(
                'Discipline__c',
                tm.Discipline__c
            );

            row.put(
                'Resource_Time_Allocation__c',
                tm.Resource_Time_Allocation__c
            );

            row.put(
                'initiativeName',
                tm.Initiative__r != null
                ? tm.Initiative__r.Name
                : ''
            );

            results.add(row);

        }

        return results;
    }


    @AuraEnabled
    public static void deleteTeamMember(
        Id teamMemberId
    ){

        Team_Member__c tm =
        [
            SELECT Id
            FROM Team_Member__c
            WHERE Id = :teamMemberId
            LIMIT 1
        ];

        delete tm;
    }


    @AuraEnabled
    public static void transferTeamMember(
        Id teamMemberId,
        Id newUserId
    ){

        Team_Member__c tm =
        [
            SELECT Id,
                   User__c
            FROM Team_Member__c
            WHERE Id = :teamMemberId
            LIMIT 1
        ];

        tm.User__c = newUserId;

        update tm;
    }

}