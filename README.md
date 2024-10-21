# Date Last CI

This is a GitHub Action that gets the date of the last time the CI was passed. There are different formats, which you upload to gist and then use it in a badge inside your README.md file or other files where you want to display it.

## Use case
- You have an action that is launched every certain time automatically.
- Show the last time the repository was checked out.

## How to use it
1. Go to [Gist](https://gist.github.com/) and create a new Gist. This can be public or private. We recommend that you use `date.json` as the name, but you can use whatever name you prefer.

![image](https://github.com/user-attachments/assets/ac36817f-17fb-4dd1-bf66-02ac03dcb2af)

2. When you create your gist, save the gist id of your repository that you will find in the url. For example, my url is `https://gist.github.com/Juancams/1954850ee87f244a87d72d2636d6bfff` , so my gist id will be `1954850ee87f244a87d72d2636d6bfff`.

3. Now we need to create a token so we can access gist. To do this, move to [tokens](https://github.com/settings/tokens/new) and create it, giving it access to gist, setting an expiration date and giving it a descriptive name. Remember to save your token in a file, as we will use it in the next step.
 
![image](https://github.com/user-attachments/assets/3994d359-0ccc-4d00-85ae-871b2cdc6ab1)

4. You need to add your new github token to the repository secrets. To do this, go to `Settings > Secrets > Actions` in your repository, and add the token you generated in previous step, copying the contents of it here.

5. Having already created a yaml that launches a github action, add this action to the end of your file, using the gist id generated in step 2 and the secret generated in the previous step.
```yaml
- name: Date Action CI
        uses: Juancams/date-last-ci@v1.0.0
        with:
          gist_id: <GIST-ID>
          gist_token: ${{ secrets.GIST_TOKEN }}
```

When you push, the content you had in gist will be updated. Now, you can add the following line to your README.md or file where you want to display your badge:
```yaml
![badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/<YOUR-USER>/<GIST-ID>/raw/date.json)
```

## Parameters
### Required Input Parameters
| Parameter     | Description                                          |
| ------------- | ---------------------------------------------------- |
| `gist_id`     | Gist ID of the repository where your file is located |
| `gist_token`  | Token generated on github with access to gist        | 

### Optional Input Parameters
| Parameter     | Description                                              | Default     |
| ------------- | -------------------------------------------------------- | ----------- |
| `gist_filename` | Name of the file hosted in gist                        | `date.json` |
| `color`         | Color for the badge                                    | `'blue'`    |
| `show_year`     | The year is displayed in the date message              | `true`      |
| `show_month`    | The month is displayed in the date message             | `true`      | 
| `show_day`      | The day number is displayed in the date message        | `true`      | 
| `show_hour`     | The hour with minutes is displayed in the date message | `true`      | 

## Author & Maintainer

* [Juan Carlos Manzanares](https://github.com/Juancams)
