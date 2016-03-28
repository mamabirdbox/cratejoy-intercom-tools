## Tool 2: Update User Info in Intercom

---

This is a tool to update some common user data that we often will get via email from the user, and isn't updated automatically because they're not on our site submitting these updates.

The tool would let us search for a user by name, email or UserID and then pull the current details on that user in from Intercom to the dashboard. We then can manually update details and submit the data back to Intercom.

The most commonly edited data will be:
-[ ] Baby Due Date ("babyduedate" custom attribute)
-[ ] First Name
-[ ] Last Name
-[ ] Email Address
-[ ] User Id

## Tool 3: Notes Sync

---

This tool is to sync notes from Intercom to CrateJoy. That would allow us to only add notes in Intercom for a user, and then have those notes appear in CrateJoy on the subscription workflow.

The complexity is that Intercom allows for multiple notes to be added for a user, whereas CrateJoy only has one note field. We'd want to append any note added in Intercom to the one single note field in CrateJoy.

In CrateJoy, the notes we want to write to are in the SUbscription Method http://docs.cratejoy.com/docs/subscription-methods

As for the tool, this would be something that could run at an interval and just sync every newly created note in Intercom to CrateJoy.

Here's the Intercom notes API (I think) https://api.intercom.io/notes from here https://developers.intercom.io/reference#api-summary

One fun addition, with Tool 1, the box shipped tool, if that tool would post a note to Intercom of "Box X shipped on mm/dd/yyyy", then that note could get passed right back to CrateJoy too. That's good data to have in the subscription workflow in CrateJoy, along with any manual notes added in Intercom.
