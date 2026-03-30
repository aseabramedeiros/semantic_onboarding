% ===== KOA Combined Output | contract_id: contrato_ocs_342_2022 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_342_2022_-_VS_Data_(Suporte_TSM).pl
% contract_id: contrato_ocs_342_2022

instance_of(contrato_ocs_342_2022, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(vs_data_comercio_distribuicao_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_342_2022).
plays_role(vs_data_comercio_distribuicao_ltda, hired_service_provider_role, contrato_ocs_342_2022).

clause_of(clausula_primeira_objeto, contrato_ocs_342_2022).
clause_of(clausula_segunda_vigencia, contrato_ocs_342_2022).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_342_2022).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_342_2022).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_342_2022).
clause_of(clausula_sexta_preco, contrato_ocs_342_2022).
clause_of(clausula_setima_pagamento, contrato_ocs_342_2022).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_342_2022).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_342_2022).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_342_2022).
clause_of(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, contrato_ocs_342_2022).
clause_of(clausula_decima_terceira_sigilo_das_informacoes, contrato_ocs_342_2022).
clause_of(clausula_decima_quarta_acesso_protecao_dados_pessoais, contrato_ocs_342_2022).
clause_of(clausula_decima_quinta_obrigações_bndes, contrato_ocs_342_2022).
clause_of(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, contrato_ocs_342_2022).
clause_of(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, contrato_ocs_342_2022).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_342_2022).
clause_of(clausula_decima_nona_alterações_contratuais, contrato_ocs_342_2022).
clause_of(clausula_vigésima_extinção_contrato, contrato_ocs_342_2022).
clause_of(clausula_vigésima_primeira_disposições_finais, contrato_ocs_342_2022).
clause_of(clausula_vigésima_segunda_foro, contrato_ocs_342_2022).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_342_2022).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, vs_data_comercio_distribuicao_ltda, provide_software_support_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, vs_data_comercio_distribuicao_ltda, provide_software_support_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_software_support_services).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, vs_data_comercio_distribuicao_ltda, present_manifestation_on_contract_extension).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, vs_data_comercio_distribuicao_ltda, communicate_interest_on_contract_extension).
legal_relation_instance(clausula_segunda_vigencia, subjection, vs_data_comercio_distribuicao_ltda, subject_to_penalties).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, vs_data_comercio_distribuicao_ltda, execute_object_according_to_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_execution_according_to_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, vs_data_comercio_distribuicao_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_execution).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_receipt_of_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_receipt).
legal_relation_instance(clausula_sexta_preco, duty_to_act, vs_data_comercio_distribuicao_ltda, bear_quantification_burdens).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_indemnification).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, vs_data_comercio_distribuicao_ltda, demand_indemnification).
legal_relation_instance(clausula_sexta_preco, right_to_action, vs_data_comercio_distribuicao_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, partially_execute_and_receive_object).
legal_relation_instance(clausula_sexta_preco, duty_to_act, vs_data_comercio_distribuicao_ltda, execute_contract_object).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, vs_data_comercio_distribuicao_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, vs_data_comercio_distribuicao_ltda, present_invoice).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_values).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_invoice).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, vs_data_comercio_distribuicao_ltda, provide_supporting_documents).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, vs_data_comercio_distribuicao_ltda, request_price_adjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, vs_data_comercio_distribuicao_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, vs_data_comercio_distribuicao_ltda, submit_documentation_for_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, vs_data_comercio_distribuicao_ltda, present_information_upon_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_adjustment_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, vs_data_comercio_distribuicao_ltda, receive_retroactive_financial_effects).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, rescind_contract).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, vs_data_comercio_distribuicao_ltda, receive_reimbursement_upon_termination).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, vs_data_comercio_distribuicao_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, vs_data_comercio_distribuicao_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, vs_data_comercio_distribuicao_ltda, obtain_new_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, vs_data_comercio_distribuicao_ltda, renew_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_deadline_for_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalty).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, communicate_penalty).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, repair_correct_remove_reconstruct_substitute).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, repair_damages).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, pay_charges_and_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, assume_responsibility_for_tax_burden).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, provide_exclusion_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, vs_data_comercio_distribuicao_ltda, appoint_representative).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, maintain_integrity).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, vs_data_comercio_distribuicao_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, vs_data_comercio_distribuicao_ltda, prevent_favored_participation).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, prevent_allocation_of_family).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, observe_policies).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, adopt_sustainability_practices).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, remove_agents_implying_impediments).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, inform_bndes_of_fact).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, vs_data_comercio_distribuicao_ltda, prevent_administrators_from_undue_advantage).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, vs_data_comercio_distribuicao_ltda, comply_bndes_security_policy).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, vs_data_comercio_distribuicao_ltda, not_access_confidential_info).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, vs_data_comercio_distribuicao_ltda, maintain_information_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, vs_data_comercio_distribuicao_ltda, limit_access_to_info).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, vs_data_comercio_distribuicao_ltda, report_confidentiality_breaches).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, vs_data_comercio_distribuicao_ltda, return_bndes_materials).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, vs_data_comercio_distribuicao_ltda, not_use_confidential_info).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, vs_data_comercio_distribuicao_ltda, observe_confidentiality_agreement).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, protect_fundamental_rights).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, vs_data_comercio_distribuicao_ltda, adopt_correct_security_measures).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, vs_data_comercio_distribuicao_ltda, follow_bndes_instructions).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, vs_data_comercio_distribuicao_ltda, maintain_data_confidentiality).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, vs_data_comercio_distribuicao_ltda, securely_store_data).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, vs_data_comercio_distribuicao_ltda, inform_employees).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_of_regress).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, vs_data_comercio_distribuicao_ltda, provide_data_access_channel).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, vs_data_comercio_distribuicao_ltda, inform_bndes_of_requests).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, vs_data_comercio_distribuicao_ltda, maintain_records_of_data_operations).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, appoint_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, appoint_contract_manager_substitute).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, appoint_contract_inspector).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, appoint_receipt_commission).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_internal_policies).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_information).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_investigation).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_act, vs_data_comercio_distribuicao_ltda, prove_absence_of_discriminatory_practices).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_proof_of_non_discrimination).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, verify_internal_info_system).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_contract_cession).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, vs_data_comercio_distribuicao_ltda, contract_cession).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, vs_data_comercio_distribuicao_ltda, issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, vs_data_comercio_distribuicao_ltda, omit_subcontract).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, vs_data_comercio_distribuicao_ltda, subcontract).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_act, unknown, maintain_contract_conditions).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_prejudices).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, permission_to_act, vs_data_comercio_distribuicao_ltda, undergo_corporate_operations).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, approve_corporate_succession).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, vs_data_comercio_distribuicao_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, vs_data_comercio_distribuicao_ltda, request_reconsideration).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, vs_data_comercio_distribuicao_ltda, appeal_penalty_decision).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credits).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_act, vs_data_comercio_distribuicao_ltda, comply_with_bndes_requirements).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_act, vs_data_comercio_distribuicao_ltda, comply_with_legal_obligations).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_for_refusal).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_damages).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_contract_amendment).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_amendment).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_refuse_to_amend).
legal_relation_instance(clausula_vigésima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notice_of_termination).
legal_relation_instance(clausula_vigésima_extinção_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_written_notice_of_termination).
legal_relation_instance(clausula_vigésima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_of_defense).
legal_relation_instance(clausula_vigésima_extinção_contrato, right_to_action, vs_data_comercio_distribuicao_ltda, opportunity_of_defense).
legal_relation_instance(clausula_vigésima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_unilaterally).
legal_relation_instance(clausula_vigésima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_any_time).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_strict_compliance).
legal_relation_instance(clausula_vigésima_segunda_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_rio_de_janeiro_forum).
legal_relation_instance(clausula_vigésima_segunda_foro, disability, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_another_forum).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, vs_data_comercio_distribuicao_ltda, not_create_additives_for_allocated_risks).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, vs_data_comercio_distribuicao_ltda, demand_additives_for_allocated_risks).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, vs_data_comercio_distribuicao_ltda, respect_reequilibrio).
legal_relation_instance(clausula_nona_matriz_riscos, right_to_action, vs_data_comercio_distribuicao_ltda, request_reequilibrio).

% --- Action catalog (local to this contract grounding) ---
action_type(adopt_correct_security_measures).
action_label(adopt_correct_security_measures, 'Adopt security measures').
action_type(adopt_sustainability_practices).
action_label(adopt_sustainability_practices, 'Adopt sustainability practices').
action_type(agree_to_contract_amendment).
action_label(agree_to_contract_amendment, 'Agree to amendment').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(analyze_price_adjustment_request).
action_label(analyze_price_adjustment_request, 'Analyze price adjustment request').
action_type(analyze_risks_prejudices).
action_label(analyze_risks_prejudices, 'Analyze risks and prejudices').
action_type(appeal_penalty_decision).
action_label(appeal_penalty_decision, 'Appeal penalty decision').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_penalty).
action_label(apply_penalty, 'Apply penalty').
action_type(apply_price_reduction).
action_label(apply_price_reduction, 'Apply price reduction').
action_type(appoint_contract_inspector).
action_label(appoint_contract_inspector, 'Appoint contract inspector').
action_type(appoint_contract_manager).
action_label(appoint_contract_manager, 'Appoint contract manager').
action_type(appoint_contract_manager_substitute).
action_label(appoint_contract_manager_substitute, 'Appoint substitute contract manager').
action_type(appoint_receipt_commission).
action_label(appoint_receipt_commission, 'Appoint receipt commission').
action_type(appoint_representative).
action_label(appoint_representative, 'Appoint representative').
action_type(approve_corporate_succession).
action_label(approve_corporate_succession, 'Approve corporate succession').
action_type(assume_responsibility_for_tax_burden).
action_label(assume_responsibility_for_tax_burden, 'Assume responsibility for tax burden').
action_type(be_liable_for_damages).
action_label(be_liable_for_damages, 'Be liable for damages').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Subject to penalties').
action_type(bear_quantification_burdens).
action_label(bear_quantification_burdens, 'Bear quantification burdens').
action_type(change_contract_manager).
action_label(change_contract_manager, 'Change contract manager').
action_type(choose_another_forum).
action_label(choose_another_forum, 'Choose another forum').
action_type(choose_rio_de_janeiro_forum).
action_label(choose_rio_de_janeiro_forum, 'Choose Rio de Janeiro forum').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_interest_on_contract_extension).
action_label(communicate_interest_on_contract_extension, 'Communicate interest on contract extension').
action_type(communicate_investigation).
action_label(communicate_investigation, 'Communicate investigation').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(compensate_damages_for_refusal).
action_label(compensate_damages_for_refusal, 'Compensate for refusal').
action_type(comply_bndes_security_policy).
action_label(comply_bndes_security_policy, 'Comply with BNDES security policy').
action_type(comply_with_bndes_requirements).
action_label(comply_with_bndes_requirements, 'Comply with BNDES requirements').
action_type(comply_with_legal_obligations).
action_label(comply_with_legal_obligations, 'Comply with legal obligations').
action_type(contract_cession).
action_label(contract_cession, 'No right to assign contract').
action_type(deduct_credits).
action_label(deduct_credits, 'Deduct credits').
action_type(deduct_values).
action_label(deduct_values, 'Deduct values').
action_type(delete_data_at_end).
action_label(delete_data_at_end, 'Delete data at end').
action_type(demand_additives_for_allocated_risks).
action_label(demand_additives_for_allocated_risks, 'Cannot demand addenda for allocated risks.').
action_type(demand_indemnification).
action_label(demand_indemnification, 'Demand indemnification').
action_type(demand_proof_of_tax_regularity).
action_label(demand_proof_of_tax_regularity, 'Demand proof of tax regularity').
action_type(demand_service_execution).
action_label(demand_service_execution, 'Demand service execution per standards').
action_type(disclose_personal_data_signatories).
action_label(disclose_personal_data_signatories, 'Disclose personal data signatories').
action_type(effect_receipt).
action_label(effect_receipt, 'Effect receipt').
action_type(effect_receipt_of_object).
action_label(effect_receipt_of_object, 'Effect receipt of object').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_object_according_to_specifications).
action_label(execute_object_according_to_specifications, 'Execute object per specifications').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services according to standards').
action_type(exercise_rights_any_time).
action_label(exercise_rights_any_time, 'Exercise rights anytime').
action_type(expect_execution_according_to_specifications).
action_label(expect_execution_according_to_specifications, 'Expect execution per specifications').
action_type(extend_deadline_for_guarantee).
action_label(extend_deadline_for_guarantee, 'Extend deadline for guarantee').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES instructions').
action_type(formalize_contract_amendment).
action_label(formalize_contract_amendment, 'Formalize amendment').
action_type(guarantee_no_infringement).
action_label(guarantee_no_infringement, 'Guarantee no infringement').
action_type(inform_bndes_of_fact).
action_label(inform_bndes_of_fact, 'Inform BNDES of fact').
action_type(inform_bndes_of_requests).
action_label(inform_bndes_of_requests, 'Inform BNDES of requests').
action_type(inform_employees).
action_label(inform_employees, 'Inform employees').
action_type(inform_professionals_about_banking_secrecy).
action_label(inform_professionals_about_banking_secrecy, 'Inform about banking secrecy').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Initiate price revision').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(limit_access_to_info).
action_label(limit_access_to_info, 'Limit access to information').
action_type(maintain_contract_conditions).
action_label(maintain_contract_conditions, 'Maintain contract conditions').
action_type(maintain_data_confidentiality).
action_label(maintain_data_confidentiality, 'Maintain data confidentiality').
action_type(maintain_information_confidentiality).
action_label(maintain_information_confidentiality, 'Maintain information confidentiality').
action_type(maintain_integrity).
action_label(maintain_integrity, 'Maintain integrity').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(maintain_records_of_data_operations).
action_label(maintain_records_of_data_operations, 'Maintain records of data operations').
action_type(make_payment).
action_label(make_payment, 'Make payment').
action_type(make_payments).
action_label(make_payments, 'Make payments to contractor').
action_type(not_access_confidential_info).
action_label(not_access_confidential_info, 'Do not access confidential info').
action_type(not_create_additives_for_allocated_risks).
action_label(not_create_additives_for_allocated_risks, 'Do not create addenda for allocated risks.').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_refuse_to_amend).
action_label(not_refuse_to_amend, 'Not refuse amendment').
action_type(not_use_confidential_info).
action_label(not_use_confidential_info, 'Do not use confidential information').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_confidentiality_agreement).
action_label(observe_confidentiality_agreement, 'Observe confidentiality agreement').
action_type(observe_policies).
action_label(observe_policies, 'Observe policies').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract assignment').
action_type(omit_indemnification).
action_label(omit_indemnification, 'Omit indemnification').
action_type(omit_issue_credit_title).
action_label(omit_issue_credit_title, 'Omit issuing credit title').
action_type(omit_strict_compliance).
action_label(omit_strict_compliance, 'Omit strict compliance').
action_type(omit_subcontract).
action_label(omit_subcontract, 'Omit subcontracting').
action_type(opportunity_of_defense).
action_label(opportunity_of_defense, 'Opportunity of defense').
action_type(partially_execute_and_receive_object).
action_label(partially_execute_and_receive_object, 'Partially execute/receive object').
action_type(pay_charges_and_taxes).
action_label(pay_charges_and_taxes, 'Pay charges and taxes').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay contracted party').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_information_upon_request).
action_label(present_information_upon_request, 'Present information upon request').
action_type(present_invoice).
action_label(present_invoice, 'Present Invoice').
action_type(present_manifestation_on_contract_extension).
action_label(present_manifestation_on_contract_extension, 'Present manifestation on contract extension').
action_type(prevent_administrators_from_undue_advantage).
action_label(prevent_administrators_from_undue_advantage, 'Prevent undue advantage').
action_type(prevent_allocation_of_family).
action_label(prevent_allocation_of_family, 'Prevent allocation of family').
action_type(prevent_favored_participation).
action_label(prevent_favored_participation, 'Prevent favored participation').
action_type(prevent_participation_of_bndes_employees).
action_label(prevent_participation_of_bndes_employees, 'Prevent participation of BNDES employees').
action_type(protect_fundamental_rights).
action_label(protect_fundamental_rights, 'Protect fundamental rights').
action_type(prove_absence_of_discriminatory_practices).
action_label(prove_absence_of_discriminatory_practices, 'Prove absence of discrimination').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_data_access_channel).
action_label(provide_data_access_channel, 'Provide data access channel').
action_type(provide_exclusion_from_simples_nacional).
action_label(provide_exclusion_from_simples_nacional, 'Provide exclusion from Simples Nacional').
action_type(provide_information).
action_label(provide_information, 'Provide information').
action_type(provide_internal_policies).
action_label(provide_internal_policies, 'Provide internal policies').
action_type(provide_opportunity_of_defense).
action_label(provide_opportunity_of_defense, 'Provide opportunity for defense').
action_type(provide_software_support_services).
action_label(provide_software_support_services, 'Provide software support services').
action_type(provide_supporting_documents).
action_label(provide_supporting_documents, 'Provide supporting documents').
action_type(provide_written_notice_of_termination).
action_label(provide_written_notice_of_termination, 'Provide written notice').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_reimbursement_upon_termination).
action_label(receive_reimbursement_upon_termination, 'Receive reimbursement upon termination').
action_type(receive_retroactive_financial_effects).
action_label(receive_retroactive_financial_effects, 'Receive retroactive financial effects').
action_type(receive_software_support_services).
action_label(receive_software_support_services, 'Receive software support services').
action_type(receive_written_notice_of_termination).
action_label(receive_written_notice_of_termination, 'Receive written notice').
action_type(reject_invoice).
action_label(reject_invoice, 'Reject invoice').
action_type(remove_agents_implying_impediments).
action_label(remove_agents_implying_impediments, 'Remove agents implying impediments').
action_type(renew_guarantee).
action_label(renew_guarantee, 'Renew Guarantee').
action_type(repair_correct_remove_reconstruct_substitute).
action_label(repair_correct_remove_reconstruct_substitute, 'Repair defects').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages to BNDES').
action_type(report_confidentiality_breaches).
action_label(report_confidentiality_breaches, 'Report confidentiality breaches').
action_type(report_data_incidents).
action_label(report_data_incidents, 'Report data incidents').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_proof_of_non_discrimination).
action_label(request_proof_of_non_discrimination, 'Request proof of non-discrimination').
action_type(request_proof_of_qualification).
action_label(request_proof_of_qualification, 'Request proof of qualification').
action_type(request_reconsideration).
action_label(request_reconsideration, 'Request reconsideration').
action_type(request_reequilibrio).
action_label(request_reequilibrio, 'Request economic-financial re-equilibrio.').
action_type(rescind_contract).
action_label(rescind_contract, 'Rescind contract').
action_type(respect_reequilibrio).
action_label(respect_reequilibrio, 'Respect economic-financial equilibrium clause.').
action_type(return_bndes_materials).
action_label(return_bndes_materials, 'Return BNDES materials').
action_type(right_of_regress).
action_label(right_of_regress, 'Right of regress').
action_type(securely_store_data).
action_label(securely_store_data, 'Securely store data').
action_type(subcontract).
action_label(subcontract, 'No right to subcontract').
action_type(subject_to_penalties).
action_label(subject_to_penalties, 'Subject to penalties').
action_type(submit_documentation_for_revision).
action_label(submit_documentation_for_revision, 'Submit documentation for revision').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_unilaterally).
action_label(terminate_contract_unilaterally, 'Terminate contract unilaterally').
action_type(treat_data_para_quarto).
action_label(treat_data_para_quarto, 'Treat data (para quarto)').
action_type(undergo_corporate_operations).
action_label(undergo_corporate_operations, 'Allowed corporate operations').
action_type(verify_internal_info_system).
action_label(verify_internal_info_system, 'Verify internal info system').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_342_2022).
contract_metadata(contrato_ocs_342_2022, numero_ocs, '342/2022').
contract_metadata(contrato_ocs_342_2022, numero_sap, '4400005303').
contract_metadata(contrato_ocs_342_2022, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_342_2022, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'VS DATA COMÉRCIO & DISTRIBUIÇÃO LTDA']).
contract_metadata(contrato_ocs_342_2022, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_342_2022, contratado, 'VS DATA COMÉRCIO & DISTRIBUIÇÃO LTDA').
contract_metadata(contrato_ocs_342_2022, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_342_2022, cnpj_contratado, '07.268.152/0001-19').
contract_metadata(contrato_ocs_342_2022, procedimento_licitatorio, 'Pregão Eletrônico nº 044/2022 - BNDES').
contract_metadata(contrato_ocs_342_2022, data_autorizacao, '02/12/2022').
contract_metadata(contrato_ocs_342_2022, ip_ati_degat, '034/2022').
contract_metadata(contrato_ocs_342_2022, data_ip_ati_degat, '30/11/2022').
contract_metadata(contrato_ocs_342_2022, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_342_2022, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_342_2022, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_342_2022, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_342_2022, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação continuada de serviços de atualização e suporte técnico (S&S – Support & Subscription) dos módulos já licenciados ao BNDES da suíte de software IBM Spectrum Protect, conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 044/2022 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_342_2022, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 24 (vinte e quatro) meses, a contar da data de sua assinatura, podendo ser prorrogado, mediante aditivo, por períodos sucessivos, até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro O CONTRATADO deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Segundo Independente da notificação do parágrafo anterior, o CONTRATADO deverá comunicar ao Gestor seu interesse quanto à prorrogação do contrato até 90 (noventa) dias antes do término de cada período de vigência contratual.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar, dispensando-se a assinatura do CONTRATADO.  Parágrafo Quarto Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_342_2022, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_342_2022, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_342_2022, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor ou da Comissão de Recebimento, com o apoio do Fiscal do Contrato, mencionados na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_342_2022, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 2.078.091,76 (dois milhões, setenta e oito mil, noventa e um reais e setenta e seis centavos), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_342_2022, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, anualmente e de forma antecipada, por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço/fornecimento do bem.   Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quinto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Sexto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF;  XIV. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sétimo Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Oitavo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Nono O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Décimo Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;  Parágrafo Décimo Primeiro Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Segundo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Terceiro Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Décimo Quarto Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_342_2022, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 22/12/2022, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação a aplicação do Índice de Custo da Tecnologia da Informação (ICTI), divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.', 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 22/12/2022, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação a aplicação do Índice de Custo da Tecnologia da Informação (ICTI), divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_342_2022, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_342_2022, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL  O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 103.904,59 (cento e três mil, novecentos e quatro reais e cinquenta e nove centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.     Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.', 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL  O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 103.904,59 (cento e três mil, novecentos e quatro reais e cinquenta e nove centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.     Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_342_2022, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII. Impedir a participação, direta ou indireta, de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do Contrato; XIII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIV. Informar a seus profissionais que algumas das informações às quais terão acesso são protegidas pela Lei de Sigilo Bancário e que, portanto, qualquer divulgação não autorizada de tais informações poderá ser caracterizada como ato criminoso, com possíveis implicações de ordem penal aos infratores.pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES;').
contract_clause(contrato_ocs_342_2022, clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_342_2022, clausula_decima_terceira_sigilo_das_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato; e V. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Termo de Confidencialidade para Representante Legal) deste Contrato.').
contract_clause(contrato_ocs_342_2022, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:    I.Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II.O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III.O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV.O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação;  V.Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto; VI.O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;  VII.Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.   VIII.O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.  IX.O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X.O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais.  XI.O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  XII.O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais. XIII.Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  XIV.Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.   Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.    Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei no 13.709/2018 (Lei Geral de Proteção de Dados - LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.').
contract_clause(contrato_ocs_342_2022, clausula_decima_quinta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Marcelo Pinto do Nascimento, que atualmente exerce a função de Coordenador de Serviço da ATI/DESET/GPRO, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. Na ausência do gestor do contrato, Marcelo Pinto do Nascimento, um dos três nomes a seguir será designado como seu substituto e informado ao Preposto: Fabrício dos Anjos Silva, Leonardo Ferreira Moura ou Otávio Frederico da Costa Roma Scheidegger, todos Analistas de Sistemas lotados na ATI/DESET/GPRO; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. designar o Fiscal do Contrato que auxiliará o Gestor do Contrato no acompanhamento, na fiscalização e na avaliação da execução do objeto;  VI. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato;  VII. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VIII. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e IX. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_342_2022, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SEXTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.').
contract_clause(contrato_ocs_342_2022, clausula_decima_setima_cessão_contrato_credito_sucessão_contratual_subcontratação, 'CLÁUSULA DÉCIMA SÉTIMA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_342_2022, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_342_2022, clausula_decima_nona_alterações_contratuais, 'CLÁUSULA DÉCIMA NONA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_342_2022, clausula_vigésima_extinção_contrato, 'CLÁUSULA VIGÉSIMA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  V. quando for decretada a falência do CONTRATADO; VI. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VII. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VIII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; X. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; XI. em razão da dissolução do CONTRATADO;  XII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_342_2022, clausula_vigésima_primeira_disposições_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade   Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_342_2022, clausula_vigésima_segunda_foro, 'CLÁUSULA VIGÉSIMA SEGUNDA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste contrato foram conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, por autorização do representante legal que o assina.   Rio de Janeiro, 11 de janeiro de 2023.     _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES      _____________________________________________________________________ VS DATA COMÉRCIO & DISTRIBUIÇÃO LTDA        Testemunhas:   _______________________________               _______________________________').

% ===== END =====
