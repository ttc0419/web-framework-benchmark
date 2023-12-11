<#import "layout.ftlh" as lo>
<@lo.top/>
<div class="card card-body">
    <h3>Search</h3>
    <form action="/record">
        <fieldset>
            <label for="name">Name</label>
            <input type="text" name="name" id="name" class="form-control mb-2">
            <div class="row">
                <div class="col-12 col-sm-4">
                    <label for="artist">Artist</label>
                    <input type="text" name="artist" id="artist" class="form-control mb-2">
                </div>
                <div class="col-12 col-sm-4">
                    <label for="year">Year (No later than)</label>
                    <input type="number" name="year" id="year" class="form-control mb-2">
                </div>
                <div class="col-12 col-sm-4">
                    <label for="genre">Genre</label>
                    <select name="genre" id="genre" class="form-select mb-4">
                        <option value selected>-- Don't filter by genre --</option>
                        <#list genres as genre>
                            <option value="${genre.id}">${genre.name}</option>
                        </#list>
                    </select>
                </div>
            </div>
        </fieldset>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <#if records??>
    <br><br>

    <div class="d-flex flex-row justify-content-between mb-2">
        <h3>Results</h3>
        <a href="/record/create" class="btn btn-primary">New Record</a>
    </div>

    <div class="table-responsive">
        <table class="table">
            <thead>
            <tr>
                <th>Name</th>
                <th>Genre</th>
                <th>Artist</th>
                <th>Year</th>
                <th>Number of Discs</th>
                <th class="actions">Actions</th>
            </tr>
            </thead>

            <tbody>
            <#if records?size == 0>
            <tr>
                <td colspan="6" class="text-center">No matched records found</td>
            </tr>
            <#else>
            <form action="/record/delete" method="post" id="deletion-form" class="d-none">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
            <#list records as record>
            <tr>
                <td>${record.name}</td>
                <td>
                    <#if record.genre??>
                    <a href="/genre/show?id=${record.genre.id}">${record.genre.name}</a>
                    <#else>
                    N/A
                    </#if>
                </td>
                <td>${record.artist}</td>
                <td>${record.year?c}</td>
                <td>${record.numberOfDiscs}</td>
                <td class="actions">
                    <a href="/record/edit?id=${record.id}" class="btn btn-sm btn-primary border-0 d-inline-block text-decoration-none">Edit</a>
                    <button type="submit" form="deletion-form" name="id" value="${record.id}"
                            class="btn btn-sm btn-danger border-0 d-inline-block">Delete
                    </button>
                </td>
            </tr>
            </#list>
            <script src="/js/confirm-deletion.js"></script>
            </#if>
            </tbody>
        </table>
    </div>
    </#if>
</div>
<@lo.bottom/>
