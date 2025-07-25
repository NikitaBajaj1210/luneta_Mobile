import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:search_choices/search_choices.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:luneta/provider/bottom_menu_provider/bottom_menu_screens_provdier/09-profile-screens-provider/professional_skills_provider.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../custom-component/custom-button.dart';

class ProfessionalSkillsScreen extends StatefulWidget {
  const ProfessionalSkillsScreen({super.key});

  @override
  State<ProfessionalSkillsScreen> createState() =>
      _ProfessionalSkillsScreenState();
}

class _ProfessionalSkillsScreenState extends State<ProfessionalSkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfessionalSkillsProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.Color_FFFFFF,
            bottomNavigationBar: Container(
              height: 11.h,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: AppColors.bottomNavBorderColor),
              ),
              child: customButton(
                voidCallback: () {
                  // Save the data in provider or update the profile here
                  Navigator.pop(context);
                },
                buttonText: "Save",
                width: 90.w,
                height: 4.h,
                color: AppColors.buttonColor,
                buttonTextColor: AppColors.buttonTextWhiteColor,
                shadowColor: AppColors.buttonBorderColor,
                fontSize: AppFontSize.fontSize18,
                showShadow: true,
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Form(
                  key: provider.formKey,
                  autovalidateMode: provider.autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button and Title
                      backButtonWithTitle(
                        title: "Professional Skills",
                        onBackPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 2.h),

                      // Computer and Software
                      buildComputerAndSoftwareSection(provider),

                      // Cargo Experience
                      buildCargoExperienceSection(provider),

                      // Cargo Gear Experience
                      buildCargoGearExperienceSection(provider),

                      // Metal Working Skills
                      buildMetalWorkingSkillsSection(provider),

                      // Tank Coating Experience
                      buildTankCoatingExperienceSection(provider),

                      // Port State Control Experience
                      buildPortStateControlExperienceSection(provider),

                      // Vetting Inspection Experience
                      buildVettingInspectionExperienceSection(provider),

                      // Trading Area Experience
                      buildTradingAreaExperienceSection(provider),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildComputerAndSoftwareSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                'Computer and Software',
                style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppColors.fontFamilyMedium,
                  color: AppColors.Color_424242,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0, top: 10),
              child: GestureDetector(
                onTap: () {
                  provider.setComputerAndSoftwareVisibility(true);
                },
                child: Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(
                      color: AppColors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 2.5.h,
                    color: AppColors.buttonTextWhiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: provider.computerAndSoftwareList.length,
          itemBuilder: (context, index) {
            ComputerAndSoftware item = provider.computerAndSoftwareList[index];
            return ListTile(
              title: Text(item.software),
              subtitle: Text(item.level),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      provider.editComputerAndSoftware(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      provider.removeComputerAndSoftware(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        if (provider.showAddSection_computerAndSoftware)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Software"),
              DropdownButton<String>(
                value: provider.software,
                hint: Text("Select Software"),
                items: provider.softwareList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  provider.setSoftware(newValue!);
                },
              ),
              SizedBox(height: 1.h),
              Text("Level"),
              DropdownButton<String>(
                value: provider.level,
                hint: Text("Select Level"),
                items: provider.levelList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  provider.setLevel(newValue!);
                },
              ),
              SizedBox(height: 1.h),
              ElevatedButton(
                onPressed: () {
                  provider.addComputerAndSoftware();
                },
                child: Text(
                    provider.computerAndSoftware_IsEdit ? "Update" : "Add"),
              ),
            ],
          ),
      ],
    );
  }

  Widget buildCargoExperienceSection(ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Cargo Experience"),
            Switch(
              value: provider.cargoExperience,
              onChanged: (value) {
                provider.setCargoExperience(value);
              },
            ),
          ],
        ),
        if (provider.cargoExperience)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bulk Cargo"),
              MultiSelectDialogField(
                items: provider.bulkCargoList
                    .map((e) => MultiSelectItem(e, e))
                    .toList(),
                onConfirm: (values) {
                  provider.bulkCargo = values.cast<String>();
                },
              ),
              Text("Tanker Cargo"),
              MultiSelectDialogField(
                items: provider.tankerCargoList
                    .map((e) => MultiSelectItem(e, e))
                    .toList(),
                onConfirm: (values) {
                  provider.tankerCargo = values.cast<String>();
                },
              ),
              Text("General Cargo"),
              MultiSelectDialogField(
                items: provider.generalCargoList
                    .map((e) => MultiSelectItem(e, e))
                    .toList(),
                onConfirm: (values) {
                  provider.generalCargo = values.cast<String>();
                },
              ),
              Text("Wood Products"),
              MultiSelectDialogField(
                items: provider.woodProductsList
                    .map((e) => MultiSelectItem(e, e))
                    .toList(),
                onConfirm: (values) {
                  provider.woodProducts = values.cast<String>();
                },
              ),
              Text("Stowage and Lashing Experience"),
              MultiSelectDialogField(
                items: provider.stowageAndLashingExperienceList
                    .map((e) => MultiSelectItem(e, e))
                    .toList(),
                onConfirm: (values) {
                  provider.stowageAndLashingExperience = values.cast<String>();
                },
              ),
            ],
          ),
      ],
    );
  }

  Widget buildCargoGearExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Cargo Gear Experience"),
            Switch(
              value: provider.cargoGearExperience,
              onChanged: (value) {
                provider.setCargoGearExperience(value);
              },
            ),
          ],
        ),
        if (provider.cargoGearExperience)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cargo Gear Experience Details"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      provider.setCargoGearExperienceVisibility(true);
                    },
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.cargoGearExperienceList.length,
                itemBuilder: (context, index) {
                  CargoGearExperience item =
                      provider.cargoGearExperienceList[index];
                  return ListTile(
                    title: Text(item.type),
                    subtitle: Text("${item.maker} - ${item.swl}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            provider.editCargoGearExperience(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            provider.removeCargoGearExperience(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_cargoGearExperience)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type"),
                    DropdownButton<String>(
                      value: provider.cargoGearType,
                      hint: Text("Select Type"),
                      items: provider.cargoGearTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        provider.setCargoGearType(newValue!);
                      },
                    ),
                    SizedBox(height: 1.h),
                    Text("Maker"),
                    customTextField(
                      context: context,
                      controller: provider.cargoGearMakerController,
                      hintText: 'Enter Maker',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {},
                    ),
                    SizedBox(height: 1.h),
                    Text("SWL"),
                    customTextField(
                      context: context,
                      controller: provider.cargoGearSWLController,
                      hintText: 'Enter SWL',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {},
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: () {
                        provider.addCargoGearExperience();
                      },
                      child: Text(provider.cargoGearExperience_IsEdit
                          ? "Update"
                          : "Add"),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  Widget buildMetalWorkingSkillsSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Metal Working Skills"),
            Switch(
              value: provider.metalWorkingSkills,
              onChanged: (value) {
                provider.setMetalWorkingSkills(value);
              },
            ),
          ],
        ),
        if (provider.metalWorkingSkills)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Metal Working Skills Details"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      provider.setMetalWorkingSkillsVisibility(true);
                    },
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.metalWorkingSkillsList.length,
                itemBuilder: (context, index) {
                  MetalWorkingSkill item =
                      provider.metalWorkingSkillsList[index];
                  return ListTile(
                    title: Text(item.skillSelection),
                    subtitle: Text(item.level),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            provider.editMetalWorkingSkill(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            provider.removeMetalWorkingSkill(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_metalWorkingSkills)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Skill Selection"),
                    DropdownButton<String>(
                      value: provider.metalWorkingSkill,
                      hint: Text("Select Skill"),
                      items:
                          provider.metalWorkingSkillsTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        provider.setMetalWorkingSkill(newValue!);
                      },
                    ),
                    SizedBox(height: 1.h),
                    Text("Level"),
                    DropdownButton<String>(
                      value: provider.metalWorkingSkillLevel,
                      hint: Text("Select Level"),
                      items: provider.metalWorkingSkillLevelList
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        provider.setMetalWorkingSkillLevel(newValue!);
                      },
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Text("Certificate"),
                        Switch(
                          value: provider.metalWorkingSkillCertificate,
                          onChanged: (value) {
                            provider.setMetalWorkingSkillCertificate(value);
                          },
                        ),
                      ],
                    ),
                    if (provider.metalWorkingSkillCertificate)
                      ElevatedButton(
                        onPressed: () {
                          provider.showAttachmentOptions(
                              context, 'metalWorkingSkill');
                        },
                        child: Text("Attach Document"),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        provider.addMetalWorkingSkill();
                      },
                      child: Text(provider.metalWorkingSkills_IsEdit
                          ? "Update"
                          : "Add"),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  Widget buildTankCoatingExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Tank Coating Experience"),
            Switch(
              value: provider.tankCoatingExperience,
              onChanged: (value) {
                provider.setTankCoatingExperience(value);
              },
            ),
          ],
        ),
        if (provider.tankCoatingExperience)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tank Coating Experience Details"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      provider.setTankCoatingExperienceVisibility(true);
                    },
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.tankCoatingExperienceList.length,
                itemBuilder: (context, index) {
                  TankCoatingExperience item =
                      provider.tankCoatingExperienceList[index];
                  return ListTile(
                    title: Text(item.type),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            provider.editTankCoatingExperience(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            provider.removeTankCoatingExperience(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_tankCoatingExperience)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type"),
                    DropdownButton<String>(
                      value: provider.tankCoatingType,
                      hint: Text("Select Type"),
                      items: provider.tankCoatingTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        provider.setTankCoatingType(newValue!);
                      },
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: () {
                        provider.addTankCoatingExperience();
                      },
                      child: Text(provider.tankCoatingExperience_IsEdit
                          ? "Update"
                          : "Add"),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  Widget buildPortStateControlExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Port State Control Experience"),
            Switch(
              value: provider.portStateControlExperience,
              onChanged: (value) {
                provider.setPortStateControlExperience(value);
              },
            ),
          ],
        ),
        if (provider.portStateControlExperience)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Port State Control Experience Details"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      provider.setPortStateControlExperienceVisibility(true);
                    },
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.portStateControlExperienceList.length,
                itemBuilder: (context, index) {
                  PortStateControlExperience item =
                      provider.portStateControlExperienceList[index];
                  return ListTile(
                    title: Text(item.regionalAgreement),
                    subtitle: Text("${item.port} - ${item.date}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            provider.editPortStateControlExperience(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            provider.removePortStateControlExperience(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (provider.showAddSection_portStateControlExperience)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Regional Agreement"),
                    DropdownButton<String>(
                      value: provider.regionalAgreement,
                      hint: Text("Select Regional Agreement"),
                      items:
                          provider.regionalAgreements.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        provider.setRegionalAgreement(newValue!);
                      },
                    ),
                    SizedBox(height: 1.h),
                    Text("Port"),
                    DropdownButton<String>(
                      value: provider.port,
                      hint: Text("Select Port"),
                      items: provider.ports.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        provider.setPort(newValue!);
                      },
                    ),
                    SizedBox(height: 1.h),
                    Text("Date"),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          provider.setDate(picked);
                        }
                      },
                      child: AbsorbPointer(
                        child: customTextField(
                          context: context,
                          controller: provider.dateController,
                          hintText: 'Select Date',
                          textInputType: TextInputType.datetime,
                          obscureText: false,
                          voidCallback: (value) {},
                          fontSize: AppFontSize.fontSize16,
                          inputFontSize: AppFontSize.fontSize16,
                          backgroundColor: AppColors.Color_FAFAFA,
                          borderColor: AppColors.buttonColor,
                          textColor: Colors.black,
                          labelColor: AppColors.Color_9E9E9E,
                          cursorColor: AppColors.Color_212121,
                          fillColor: AppColors.Color_FAFAFA,
                          onFieldSubmitted: (String) {},
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text("Observations"),
                    customTextField(
                      context: context,
                      controller: provider.observationsController,
                      hintText: 'Enter Observations',
                      textInputType: TextInputType.text,
                      obscureText: false,
                      voidCallback: (value) {},
                      fontSize: AppFontSize.fontSize16,
                      inputFontSize: AppFontSize.fontSize16,
                      backgroundColor: AppColors.Color_FAFAFA,
                      borderColor: AppColors.buttonColor,
                      textColor: Colors.black,
                      labelColor: AppColors.Color_9E9E9E,
                      cursorColor: AppColors.Color_212121,
                      fillColor: AppColors.Color_FAFAFA,
                      onFieldSubmitted: (String) {},
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: () {
                        provider.addPortStateControlExperience();
                      },
                      child: Text(provider.portStateControlExperience_IsEdit
                          ? "Update"
                          : "Add"),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  Widget buildVettingInspectionExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Vetting Inspection Experience"),
        SizedBox(height: 1.h),
        Text("Inspection By"),
        customTextField(
          context: context,
          controller: provider.inspectionByController,
          hintText: 'Enter Inspection By',
          textInputType: TextInputType.text,
          obscureText: false,
          voidCallback: (value) {},
          fontSize: AppFontSize.fontSize16,
          inputFontSize: AppFontSize.fontSize16,
          backgroundColor: AppColors.Color_FAFAFA,
          borderColor: AppColors.buttonColor,
          textColor: Colors.black,
          labelColor: AppColors.Color_9E9E9E,
          cursorColor: AppColors.Color_212121,
          fillColor: AppColors.Color_FAFAFA,
          onFieldSubmitted: (String) {},
        ),
        SizedBox(height: 1.h),
        Text("Port"),
        DropdownButton<String>(
          value: provider.vettingPort,
          hint: Text("Select Port"),
          items: provider.vettingPorts.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            provider.setVettingPort(newValue!);
          },
        ),
        SizedBox(height: 1.h),
        Text("Date"),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              provider.setVettingDate(picked);
            }
          },
          child: AbsorbPointer(
            child: customTextField(
              context: context,
              controller: provider.vettingDateController,
              hintText: 'Select Date',
              textInputType: TextInputType.datetime,
              obscureText: false,
              voidCallback: (value) {},
              fontSize: AppFontSize.fontSize16,
              inputFontSize: AppFontSize.fontSize16,
              backgroundColor: AppColors.Color_FAFAFA,
              borderColor: AppColors.buttonColor,
              textColor: Colors.black,
              labelColor: AppColors.Color_9E9E9E,
              cursorColor: AppColors.Color_212121,
              fillColor: AppColors.Color_FAFAFA,
              onFieldSubmitted: (String) {},
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Text("Observations"),
        customTextField(
          context: context,
          controller: provider.vettingObservationsController,
          hintText: 'Enter Observations',
          textInputType: TextInputType.text,
          obscureText: false,
          voidCallback: (value) {},
          fontSize: AppFontSize.fontSize16,
          inputFontSize: AppFontSize.fontSize16,
          backgroundColor: AppColors.Color_FAFAFA,
          borderColor: AppColors.buttonColor,
          textColor: Colors.black,
          labelColor: AppColors.Color_9E9E9E,
          cursorColor: AppColors.Color_212121,
          fillColor: AppColors.Color_FAFAFA,
          onFieldSubmitted: (String) {},
        ),
      ],
    );
  }

  Widget buildTradingAreaExperienceSection(
      ProfessionalSkillsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Trading Area Experience"),
        MultiSelectDialogField(
          items: provider.tradingAreaList
              .map((e) => MultiSelectItem(e, e))
              .toList(),
          onConfirm: (values) {
            provider.tradingAreaExperience = values.cast<String>();
          },
        ),
      ],
    );
  }
}

class backButtonWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;

  const backButtonWithTitle({
    Key? key,
    required this.title,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed,
        ),
        SizedBox(width: 3.w),
        Text(
          title,
          style: TextStyle(
            fontSize: AppFontSize.fontSize18,
            fontWeight: FontWeight.bold,
            color: AppColors.Color_424242,
          ),
        ),
      ],
    );
  }
}
